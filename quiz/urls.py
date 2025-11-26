# quiz/urls.py
from rest_framework.routers import DefaultRouter
from .views import QuestionViewSet, AttemptCreateView, get_categories, get_questions_by_category
from django.urls import path, include

router = DefaultRouter()
router.register(r'questions', QuestionViewSet, basename='question')

urlpatterns = [
    path('api/', include(router.urls)),
    path('api/attempts/', AttemptCreateView.as_view(), name='attempt-create'),
    path('api/categories/', get_categories, name='categories'),
    path('api/categories/<str:category>/questions/', get_questions_by_category, name='questions-by-category'),
]
