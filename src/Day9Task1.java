import java.util.LinkedList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.IntStream;

public class Day9Task1 {
    public static void main(String[] args) {
        Pattern pattern = Pattern.compile("([0-9]+) players; last marble is worth ([0-9]+) points");
        Matcher matcher = pattern.matcher(args[0]);

        matcher.find();

        int numPlayers = Integer.parseInt(matcher.group(1));
        int numMarbles = Integer.parseInt(matcher.group(2));

        List<Integer> placedMarbles = new LinkedList<>();

        placedMarbles.add(0);
        placedMarbles.add(1);

        int currentMarbleIndex = 1;
        int currentPlayer = 1;
        int[] scores = new int[numMarbles];
        int size = 2;

        for (int marble = 2; marble <= numMarbles; marble++) {
            if (marble % 23 == 0) {
                int toRemove = (currentMarbleIndex + size - 7) % size;
                int removedMarble = placedMarbles.remove(toRemove);

                size -= 1;
                scores[currentPlayer] += marble + removedMarble;
                currentMarbleIndex = toRemove;
            } else {
                int insertIndex = (currentMarbleIndex + 1) % size;
                placedMarbles.add(insertIndex + 1, marble);
                size += 1;
                currentMarbleIndex = (insertIndex + 1) % size;
            }

            currentPlayer = (currentPlayer + 1) % numPlayers;
        }

        int highscore = IntStream.of(scores).max().orElse(0);

        System.out.println(highscore);
    }
}
