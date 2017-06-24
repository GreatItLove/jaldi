package pro.jaldi;

import android.content.Context;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class WorkStatusFragment extends Fragment {

    private TextView firstItem;
    private TextView secondItem;
    private TextView thirdItem;
    private TextView fourthItem;

    private TextView firstItemTitle;
    private TextView secondItemTitle;
    private TextView thirdItemTitle;
    private TextView fourthItemTitle;

    public WorkStatusFragment() {
        // Required empty public constructor
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View contentView = inflater.inflate(R.layout.fragment_work_status, container, false);
        firstItem = (TextView) contentView.findViewById(R.id.enRouteCircleContainer);
        secondItem = (TextView) contentView.findViewById(R.id.workingCircleContainer);
        thirdItem = (TextView) contentView.findViewById(R.id.tidyingUpCircleContainer);
        fourthItem = (TextView) contentView.findViewById(R.id.finishCircleContainer);

        firstItemTitle = (TextView) contentView.findViewById(R.id.enRouteTitle);
        secondItemTitle = (TextView) contentView.findViewById(R.id.workingTitle);
        thirdItemTitle = (TextView) contentView.findViewById(R.id.tidyingUpTitle);
        fourthItemTitle = (TextView) contentView.findViewById(R.id.finishTitle);


        return contentView;
    }

    public enum WorkStatus {
        STATUS_ASSIGNED,
        STATUS_EN_ROUTE,
        STATUS_WORKING,
        STATUS_TIDYING_UP,
        STATUS_FINISHED,
    }

    public void setCurrentStatus(WorkStatus status) {
        switch (status) {
            case STATUS_ASSIGNED:
                firstItem.setText("1");
                secondItem.setText("2");
                thirdItem.setText("3");
                fourthItem.setText("4");

                firstItem.setEnabled(false);
                secondItem.setEnabled(false);
                thirdItem.setEnabled(false);
                fourthItem.setEnabled(false);

                firstItem.setSelected(false);
                secondItem.setSelected(false);
                thirdItem.setSelected(false);
                fourthItem.setSelected(false);

                firstItemTitle.setTypeface(null, Typeface.NORMAL);
                secondItemTitle.setTypeface(null, Typeface.NORMAL);
                thirdItemTitle.setTypeface(null, Typeface.NORMAL);
                fourthItemTitle.setTypeface(null, Typeface.NORMAL);

                break;
            case STATUS_EN_ROUTE:
                firstItem.setText("1");
                secondItem.setText("2");
                thirdItem.setText("3");
                fourthItem.setText("4");

                firstItem.setEnabled(true);
                secondItem.setEnabled(false);
                thirdItem.setEnabled(false);
                fourthItem.setEnabled(false);

                firstItem.setSelected(false);
                secondItem.setSelected(false);
                thirdItem.setSelected(false);
                fourthItem.setSelected(false);

                firstItemTitle.setTypeface(null, Typeface.BOLD);
                secondItemTitle.setTypeface(null, Typeface.NORMAL);
                thirdItemTitle.setTypeface(null, Typeface.NORMAL);
                fourthItemTitle.setTypeface(null, Typeface.NORMAL);

                break;
            case STATUS_WORKING:
                firstItem.setText("✓");
                secondItem.setText("2");
                thirdItem.setText("3");
                fourthItem.setText("4");

                firstItem.setEnabled(true);
                secondItem.setEnabled(true);
                thirdItem.setEnabled(false);
                fourthItem.setEnabled(false);

                firstItem.setSelected(true);
                secondItem.setSelected(false);
                thirdItem.setSelected(false);
                fourthItem.setSelected(false);

                firstItemTitle.setTypeface(null, Typeface.NORMAL);
                secondItemTitle.setTypeface(null, Typeface.BOLD);
                thirdItemTitle.setTypeface(null, Typeface.NORMAL);
                fourthItemTitle.setTypeface(null, Typeface.NORMAL);

                break;
            case STATUS_TIDYING_UP:
                firstItem.setText("✓");
                secondItem.setText("✓");
                thirdItem.setText("3");
                fourthItem.setText("4");

                firstItem.setEnabled(true);
                secondItem.setEnabled(true);
                thirdItem.setEnabled(true);
                fourthItem.setEnabled(false);

                firstItem.setSelected(true);
                secondItem.setSelected(true);
                thirdItem.setSelected(false);
                fourthItem.setSelected(false);

                firstItemTitle.setTypeface(null, Typeface.NORMAL);
                secondItemTitle.setTypeface(null, Typeface.NORMAL);
                thirdItemTitle.setTypeface(null, Typeface.BOLD);
                fourthItemTitle.setTypeface(null, Typeface.NORMAL);

                break;
            case STATUS_FINISHED:
                firstItem.setText("✓");
                secondItem.setText("✓");
                thirdItem.setText("✓");
                fourthItem.setText("✓");

                firstItem.setEnabled(true);
                secondItem.setEnabled(true);
                thirdItem.setEnabled(true);
                fourthItem.setEnabled(true);

                firstItem.setSelected(true);
                secondItem.setSelected(true);
                thirdItem.setSelected(true);
                fourthItem.setSelected(true);

                firstItemTitle.setTypeface(null, Typeface.NORMAL);
                secondItemTitle.setTypeface(null, Typeface.NORMAL);
                thirdItemTitle.setTypeface(null, Typeface.NORMAL);
                fourthItemTitle.setTypeface(null, Typeface.NORMAL);

                break;
        }
    }
}
