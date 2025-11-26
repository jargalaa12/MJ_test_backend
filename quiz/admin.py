from django.contrib import admin
from import_export import resources
from import_export.admin import ImportExportModelAdmin
from .models import Question, Choice, Attempt, AttemptAnswer

# ── Choice Inline ───────────────────────────────
class ChoiceInline(admin.TabularInline):
    model = Choice
    extra = 0

# ── Question Resource ────────────────────────────
class QuestionResource(resources.ModelResource):
    class Meta:
        model = Question

# ── Question Admin ──────────────────────────────
class QuestionAdmin(ImportExportModelAdmin):
    resource_class = QuestionResource
    list_display = ('id', 'text', 'category', 'created_at')
    inlines = [ChoiceInline]

# Unregister old admin if already registered
try:
    admin.site.unregister(Question)
except admin.sites.NotRegistered:
    pass

admin.site.register(Question, QuestionAdmin)

# ── Attempt Admin ───────────────────────────────
@admin.register(Attempt)
class AttemptAdmin(admin.ModelAdmin):
    list_display = ('id', 'score', 'total', 'created_at')  # 'user'-ийг авч хаяв
    readonly_fields = ('score', 'total', 'created_at')

# ── AttemptAnswer Admin ─────────────────────────
@admin.register(AttemptAnswer)
class AttemptAnswerAdmin(admin.ModelAdmin):
    list_display = ('attempt', 'question', 'selected_choice')
