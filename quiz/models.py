from django.conf import settings
from django.db import models

class Question(models.Model):
    CATEGORY_CHOICES = [
        ('term_def', '1. Нэр томъёо ба тодорхойлолт'),
        ('vehicle_class', '2. Механикжсан тээврийн хэрэгслийн ангилал'),
        ('driver_duty', '3. Жолоочийн үүрэг'),
        ('special_signal', '4. Тусгай дуут болон гэрлэн дохио ажиллуулсан тээврийн хэрэгслийн хөдөлгөөн'),
        ('road_sign', '5. Замын тэмдэг'),
        ('road_mark', '6. Замын тэмдэглэл'),
        ('traffic_signal', '7. Замын хөдөлгөөн зохицуулах дохио'),
        ('warning_signal', '8. Анхааруулах дохио ба таних тэмдэг'),
        ('start_turn', '9. Хөдөлгөөн эхлэх болон чиг өөрчлөх'),
        ('lane', '10. Тээврийн хэрэгсэл байрлан явах'),
        ('speed', '11. Тээврийн хэрэгслийн хурд'),
        ('overtake', '12. Гүйцэж түрүүлэх ба гүйцэх'),
        ('stop_parking', '13. Түр ба удаан зогсох'),
        ('intersection', '14. Уулзвар нэвтрэх'),
        ('pedestrian_crossing', '15. Явган хүний гарц нэвтрэх'),
        ('rail_crossing', '16. Төмөр замын гарам нэвтрэх'),
        ('lighting', '17. Гадна талын гэрэлтүүлэх хэрэгслийг хэрэглэх'),
        ('residential', '18. Хорооллын доторх хөдөлгөөн'),
        ('highway', '19. Тууш замын хөдөлгөөн'),
        ('towing', '20. Механикжсан тээврийн хэрэгслийг чирэх'),
        ('transport_people_goods', '21. Хүн ба ачаа тээвэрлэх'),
        ('vehicle_fault', '22. Тээврийн хэрэгслийн эвдрэл гэмтэл, техникийн зөрчил'),
        ('driving_theory', '23. Тээврийн хэрэгслийг аюулгүй жолоодох онол'),
        ('first_aid', '24. Эмнэлгийн анхны тусламж'),
    ]
    text = models.TextField()
    category = models.CharField(max_length=50, choices=CATEGORY_CHOICES, default='term_def')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.id} - {self.text[:60]}"


class Choice(models.Model):
    question = models.ForeignKey(Question, related_name='choices', on_delete=models.CASCADE)
    text = models.CharField(max_length=255)
    is_correct = models.BooleanField(default=False)  # зөв хариулт тэмдэглэх

    def __str__(self):
        return f"{self.question.id} - {self.text[:40]}"


class Attempt(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL)
    score = models.PositiveIntegerField(default=0)
    total = models.PositiveIntegerField(default=0)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Attempt {self.id} - {self.score}/{self.total}"


class AttemptAnswer(models.Model):
    attempt = models.ForeignKey(Attempt, related_name='answers', on_delete=models.CASCADE)
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    selected_choice = models.ForeignKey(Choice, null=True, blank=True, on_delete=models.SET_NULL)

    def __str__(self):
        return f"Attempt {self.attempt.id} Q{self.question.id}"
