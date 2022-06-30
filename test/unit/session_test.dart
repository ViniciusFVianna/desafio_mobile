import 'package:desafio_mobile/app/modules/session/controllers/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:desafio_mobile/main.dart' as app;
import 'package:integration_test/integration_test.dart';

 void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
group('Test SessionController', (){
  app.main();
  test('Campo de email conter email@email.com', () {
      final controller = SessionController();
      controller.txtEmail.value.text = 'teste@teste.com';
      expect(controller.txtEmail.value.text, 'teste@teste.com');
  });

  test('Campo de senha conter Te123!@#', () {
      final controller = SessionController();
      controller.txtPassword.value.text = 'Te123!@#';
      expect(controller.txtEmail.value.text, 'Te123!@#');
  });

  test('Teste login firebase', () {
      final controller = SessionController();
      controller.txtEmail.value.text = 'teste@teste.com';
      controller.txtPassword.value.text = 'Te123!@#';

      
      expect(controller.txtEmail.value.text, 'Te123!@#');
  });
});
}