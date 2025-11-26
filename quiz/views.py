# quiz/views.py
from rest_framework import viewsets, generics, status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated

from .models import Question, Choice, Attempt, AttemptAnswer
from .serializers import (
    QuestionSerializer,
    AttemptCreateSerializer,
    AttemptResultSerializer
)

# ----------------------------
# Question ViewSet (ReadOnly)
# ----------------------------
class QuestionViewSet(viewsets.ReadOnlyModelViewSet):
    queryset = Question.objects.all()
    serializer_class = QuestionSerializer

# ----------------------------
# Attempt үүсгэх API
# ----------------------------
class AttemptCreateView(generics.CreateAPIView):
    serializer_class = AttemptCreateSerializer
    permission_classes = [IsAuthenticated]

    def post(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        answers_data = serializer.validated_data['answers']

        attempt = Attempt.objects.create(user=request.user)
        score = 0
        total = len(answers_data)

        for item in answers_data:
            question = Question.objects.get(pk=item['question'])
            selected_choice = Choice.objects.filter(pk=item['selected_choice']).first() if item['selected_choice'] else None
            AttemptAnswer.objects.create(
                attempt=attempt,
                question=question,
                selected_choice=selected_choice
            )

            # Зөв сонголтыг тооцоолох
            if selected_choice and selected_choice.is_correct:
                score += 1

        attempt.score = score
        attempt.total = total
        attempt.save()

        result_serializer = AttemptResultSerializer(attempt)
        return Response(result_serializer.data, status=status.HTTP_201_CREATED)

# ----------------------------
# Category болон Question API
# ----------------------------
@api_view(['GET'])
def get_categories(request):
    """
    Бүх distinct category жагсаалт буцаана
    """
    categories = Question.objects.values_list('category', flat=True).distinct()
    return Response(sorted(list(categories)))


@api_view(['GET'])
def get_questions_by_category(request, category):
    """
    Сонгосон category-ийн асуултуудыг буцаана
    """
    questions = Question.objects.filter(category=category)
    serializer = QuestionSerializer(questions, many=True)
    return Response(serializer.data)
