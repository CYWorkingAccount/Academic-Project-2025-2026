import java.io.File;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;

public class Main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        FXMLLoader loader = new FXMLLoader();
        loader.setLocation(getClass().getResource("res/tp6_Sae.fxml"));
        BorderPane root = loader.load();
        Scene scene = new Scene(root, 1500, 800);
        primaryStage.setScene(scene);
        primaryStage.setTitle("Assistant de voyage");
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}
