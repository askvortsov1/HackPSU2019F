from rest_framework import serializers
from allauth.account.adapter import get_adapter
from allauth.account import app_settings as allauth_settings
from allauth.utils import email_address_exists
from allauth.account.utils import setup_user_email, user_email
from django.contrib.auth import get_user_model


class RegisterSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True)
    fname = serializers.CharField(required=True)
    lname = serializers.CharField(required=True)
    gender = serializers.CharField(required=True)
    birthday = serializers.DateField(required=True)
    password1 = serializers.CharField(write_only=True)
    password2 = serializers.CharField(write_only=True)

    def validate_email(self, email):
        email = get_adapter().clean_email(email)
        if allauth_settings.UNIQUE_EMAIL:
            if email and email_address_exists(email):
                raise serializers.ValidationError(
                    "A user is already registered with this e-mail address.")
        return email

    def validate_password1(self, password):
        return get_adapter().clean_password(password)

    def validate(self, data):
        if data['password1'] != data['password2']:
            raise serializers.ValidationError("The two password fields didn't match.")
        return data

    def custom_signup(self, request, user):
        pass

    def get_cleaned_data(self):
        return {
            'password1': self.validated_data.get('password1', ''),
            'email': self.validated_data.get('email'),
            'fname': self.validated_data.get('fname'),
            'lname': self.validated_data.get('lname'),
            'birthday': self.validated_data.get('birthday'),
        }

    def save(self, request):
        adapter = get_adapter()
        user = adapter.new_user(request)
        self.cleaned_data = self.get_cleaned_data()
        for k, v in self.cleaned_data.items():
            if k in ['password1', 'email']:
                continue
            setattr(user, k, v)
        user_email(user, self.cleaned_data['email'])
        user.set_password(self.cleaned_data['password1'])
        user.save()
        self.custom_signup(request, user)
        setup_user_email(request, user, [])
        return user


class UserDetailsSerializer(serializers.ModelSerializer):
    """
    User model w/o password
    """
    class Meta:
        model = get_user_model()
        fields = ('pk', 'email', 'fname', 'lname', 'birthday', 'gender')
        read_only_fields = ('email', )
