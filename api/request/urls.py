from rest_framework.routers import DefaultRouter
from .views import HelpRequestViewSet, HelpRequestCreate, HelpRequestDestroy
from django.urls import path


urlpatterns = [
    path('requests/create/', HelpRequestCreate),
    path('requests/destroy/', HelpRequestDestroy),
]
router = DefaultRouter()
router.register(r'requests', HelpRequestViewSet, basename='user')
urlpatterns += router.urls
