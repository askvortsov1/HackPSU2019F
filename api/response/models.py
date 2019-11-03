from django.db import models
from request.models import HelpRequest
from accounts.models import User
from django.utils import timezone

# Create your models here.


class HelpResponse(models.Model):
    request = models.ForeignKey(HelpRequest, on_delete=models.CASCADE)

    assisting_user = models.ForeignKey(User, on_delete=models.CASCADE)

    datetime = models.DateTimeField(default=timezone.now)


class HelperReview(models.Model):
    rating = models.FloatField()

    datetime = models.DateTimeField(default=timezone.now)

    reviewer = models.ForeignKey(User, on_delete=models.PROTECT)

    flag = models.BooleanField(default=False)
