#!/usr/bin/env python
import os
import django
import openpyxl

# Django-г тохируулах
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'MJ_test_backend.settings')
django.setup()

from quiz.models import Question, Choice

# XLSX файл
wb = openpyxl.load_workbook('quiz_questions.xlsx')
sheet = wb.active

# Үндсэн импорт цикл
for row in sheet.iter_rows(min_row=2, values_only=True):
    # Хоосон багануудыг default-тэй хуваарилах
    if len(row) >= 8:
        question_text, choice_a, choice_b, choice_c, choice_d, choice_e, correct, category = row
    else:
        question_text, choice_a, choice_b, choice_c, choice_d, correct = row[:6]
        choice_e = None
        category = 'general'

    if not question_text:
        continue  # Хоосон асуулт алгасах

    q = Question.objects.create(
        text=str(question_text).strip(),
        category=str(category).strip() if category else 'general'
    )

    choices = [choice_a, choice_b, choice_c, choice_d, choice_e]
    letters = ['A', 'B', 'C', 'D', 'E']

    for idx, c_text in enumerate(choices):
        if not c_text:
            continue  # Хоосон choice-г алгасах

        is_correct = False
        if correct and isinstance(correct, str):
            is_correct = (letters[idx] == correct.strip())

        Choice.objects.create(
            question=q,
            text=str(c_text).strip(),
            is_correct=is_correct
        )

print("Импорт амжилттай дууслаа!")
