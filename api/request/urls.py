from rest_framework.routers import DefaultRouter
from .views import HelpRequestViewSet, HelpRequestCreate, HelpRequestDestroy
from django.urls import path


router = DefaultRouter()
router.register(r'requests', HelpRequestViewSet, basename='user')
urlpatterns = router.urls
urlpatterns += [
    path('requests/create/', HelpRequestCreate),
    path('requests/destroy/', HelpRequestDestroy),
]
