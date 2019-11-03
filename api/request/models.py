from django.db import models
from accounts.models import User
from django.utils import timezone


class HelpRequest(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    CHOICES = (
        ("s", "Shelter"),
        ("f", "Food"),
        ("w", "Water"),
        ("t", "Toiletries"),
        ("c", "Clothes")
    )

    item = models.CharField(max_length=1, choices=CHOICES)

    item_description = models.TextField()

    datetime = models.DateTimeField(default=timezone.now)

    severity = models.IntegerField()

    severity_detail = models.TextField()



class AskerReview(models.Model):
    rating = models.FloatField()

    datetime = models.DateTimeField(default=timezone.now)

    reviewer = models.ForeignKey(User, on_delete=models.PROTECT)

    flag = models.BooleanField(default=False)
