from django.contrib import admin
from .models import HelpRequest, AskerReview

# Register your models here.
admin.site.register(HelpRequest)
admin.site.register(AskerReview)