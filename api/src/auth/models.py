from django.contrib.auth.models import (AbstractBaseUser, BaseUserManager,
                                        PermissionsMixin)
from django.db import models
from django.utils import timezone
from django.utils.translation import gettext_lazy as _


class UserManager(BaseUserManager):
    use_in_migrations = True

    def _create_user(self, email, password, **extra_fields):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('The given email must be set')
        email = self.normalize_email(email)
        user = self.model(email=email, **extra_fields)
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_user(self, email, password=None, **extra_fields):
        extra_fields.setdefault('is_superuser', False)
        return self._create_user(email, password, **extra_fields)

    def create_superuser(self, email, password, **extra_fields):
        extra_fields.setdefault('is_superuser', True)
        extra_fields.setdefault('is_staff', True)

        if extra_fields.get('is_superuser') is not True:
            raise ValueError('Superuser must have is_superuser=True.')

        return self._create_user(email, password, **extra_fields)


class User(AbstractBaseUser, PermissionsMixin):
    email = models.EmailField(
        _('email'),
        max_length=255,
        unique=True,
        error_messages={
            'unique': _("A user with that email already exists."),
        },
        null=False,
        help_text="Enter a valid email. If you are a current IYNA staff member, do not use your @youthneuro.org account."
    )

    # User Classifications
    is_active = models.BooleanField(
        _('active?'),
        default=True,
        help_text=_('Designates whether this user can log in.')
    )

    is_staff = models.BooleanField(
        _('staff?'),
        default=False,
        help_text="Can this user log in to the admin panel."
    )

    is_superuser = models.BooleanField(
        _('admin?'),
        default=False,
        help_text="Does this user have access to all permissions."
    )

    # Identity Info
    fname = models.CharField(
        _('First Name'),
        max_length=30,
        help_text="Enter your first name."
    )

    lname = models.CharField(
        _('Last Name'),
        max_length=150,
        help_text="Enter your last name."
    )

    # Age
    birthday = models.DateField(
        _('birthday'),
        null=True,
        help_text="Enter your birthday."
    )

    # Administrative Info
    date_joined = models.DateTimeField(
        _('Date Joined'),
        default=timezone.now,
        help_text="When did this user join?"
    )

    # Model Config
    EMAIL_FIELD = 'email'
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['fname', 'lname', 'birthday', 'country']
    EXPORTED_FIELDS = ['email', 'fname', 'lname', 'bio', 'birthday', 'country']
    REQUIRED_SITE_SPECIFIC_FIELDS = ['role']

    objects = UserManager()
