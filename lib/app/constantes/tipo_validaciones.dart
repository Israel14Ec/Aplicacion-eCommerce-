class TipoValidaciones {
  
  // Singleton
  TipoValidaciones._privateConstructor();
  static final TipoValidaciones _instancia = TipoValidaciones._privateConstructor();
  static TipoValidaciones get instancia => _instancia;

  // Alerta al ingresar valores (o no)
  final String _alertaCampoVacio = 'Se dede llenar el campo';
  final String _alertaEmailNoValido = 'Direccion de correo electronico no es valida';
  final String _alertaPasswordLongitud = 'La contraseña debe tener al menos 6 caracteres';
  final String _alertaConfirmarPassword = 'La contraseña no coincide con la anterior';
  final String _alertaNumeroTarjetaLongitud = 'Los números de la tarjeta de credito van de 8 a 19 digitos';
  final String _alertaCvvLongitud = 'El CVV son 3 digitos en el reverso de la tarjeta de credito';
  final String _alertaNumeroTelefonicoLongitud = 'El número telefónico debe tener al menos 10 números';

  String? validacionEmail(String? valor) {
    RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    if (!emailRegex.hasMatch(valor)) {
      return _alertaEmailNoValido;
    }

    return null;
  }

  String? validacionPassword(String? valor) {
    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    if (valor.length < 6) {
      return _alertaPasswordLongitud;
    }

    return null;
  }

  String? validacionVacio(String? valor) {
    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    return null;
  }

  String? validacionConfirmarPassword(String? valor, String? password) {
    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    if (valor != password) {
      return _alertaConfirmarPassword;
    }

    return null;
  }

  String? validacionNumeroTelefonico(String? valor) {
    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    if (valor.length < 10) {
      return _alertaNumeroTelefonicoLongitud;
    }

    return null;
  }

  String? validacionNumeroTarjeta(String? valor) {
    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    if (valor.length < 8) {
      return _alertaNumeroTarjetaLongitud;
    }

    return null;
  }

  String? validacionCvv(String? valor) {
    if (valor == null || valor.isEmpty) {
      return _alertaCampoVacio;
    }

    if (valor.length < 3) {
      return _alertaCvvLongitud;
    }

    return null;
  }
}
