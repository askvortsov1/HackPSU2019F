from django.db import models
from accounts.models import User
from django.utils import timezone


class HelpRequest(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    item = models.CharField(max_length=100)

    item_description = models.TextField()

    datetime = models.DateTimeField(default=timezone.now)

    severity = models.IntegerField()

    severity_detail = models.TextField()
