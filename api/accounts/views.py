from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse
from .models import User


def email_to_id(request):
    email = request.GET.get("email")
    user = get_object_or_404(User, email=email)
    return JsonResponse({"id": user.id, "email": user.email})
