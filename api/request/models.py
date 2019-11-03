from django.db import models
from accounts.models import User
from django.utils import timezone


class HelpRequest(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)

    item = models.CharField(max_length=100)

    item_description = models.TextField()

    datetime = models.DateTimeField(default=timezone.now)

    SEVERITIES = (
        (5, "Extremely Severe"),
        (4, "Very Severe"),
        (3, "Moderately Severe"),
        (2, "Somewhat Severe"),
        (1, "Not Severe")
    )

    severity = models.IntegerField(choices=SEVERITIES)

    severity_detail = models.TextField()
