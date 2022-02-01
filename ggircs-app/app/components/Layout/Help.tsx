import {
  Popover,
  PopoverHeader,
  PopoverBody,
  OverlayTrigger,
} from "react-bootstrap";

interface Props {
  title?: string | JSX.Element;
  helpMessage?: string | JSX.Element;
}

export const HelpComponent: React.FC<Props> = (props) => {
  const popover = (
    <Popover className="ciip-help" id="popover-basic">
      <PopoverHeader as="h3">{props.title}</PopoverHeader>
      <PopoverBody>{props.helpMessage}</PopoverBody>
    </Popover>
  );

  return (
    <>
      <OverlayTrigger trigger="hover" placement="right" overlay={popover}>
        <div className="help-trigger-container">
          <span className="help-trigger">?</span>
        </div>
      </OverlayTrigger>
      <style jsx>
        {`
          .help-trigger-container {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            border: 1px solid #004085;
            width: 20px;
            height: 20px;
            border-radius: 20px;
            cursor: pointer;
            margin-left: 10px;
          }
          .help-trigger {
            display: inline-block;
            color: #004085;
          }
        `}
      </style>
    </>
  );
};

HelpComponent.defaultProps = {
  title: null,
  helpMessage: null,
};

export default HelpComponent;
