# quiz/serializers.py
from rest_framework import serializers
from .models import Question, Choice, Attempt, AttemptAnswer

class ChoiceSerializer(serializers.ModelSerializer):
    class Meta:
        model = Choice
        fields = ('id', 'text')

class QuestionSerializer(serializers.ModelSerializer):
    choices = ChoiceSerializer(many=True, read_only=True)  # related_name="choices"

    class Meta:
        model = Question
        fields = ('id', 'text', 'category', 'choices')

class AttemptAnswerInputSerializer(serializers.Serializer):
    question = serializers.IntegerField()
    selected_choice = serializers.IntegerField(allow_null=True)

class AttemptCreateSerializer(serializers.Serializer):
    answers = AttemptAnswerInputSerializer(many=True)

class AttemptResultSerializer(serializers.ModelSerializer):
    answers = serializers.SerializerMethodField()

    class Meta:
        model = Attempt
        fields = ('id', 'user', 'score', 'total', 'created_at', 'answers')

    def get_answers(self, obj):
        out = []
        for a in obj.answers.all():
            out.append({
                'question': a.question.id,
                'selected_choice': a.selected_choice.id if a.selected_choice else None,
                'correct_choice_ids': [c.id for c in a.question.choices.filter(is_correct=True)]
            })
        return out
