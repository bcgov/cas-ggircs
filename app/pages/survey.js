import React , { Component } from 'react'
import SignIn from '../components/SignIn'
import {Col, Container, Row} from "react-bootstrap";
import Header from '../components/Header'
import UserList from "../components/UserList";


class Survey extends Component {
  static displayName = `Survey`;

  render(props) {
  //    var surveyCreator = new SurveyCreator.SurveyCreator("surveyCreatorDivElementID");

      return (
        <React.Fragment>
          <Header/>
          <Container>
            <Row>
              <Col>
                  <h1>About GGIRCS</h1>
                  <p>We are creating a web-application to provide reliable access to a database for BC's industrial greenhouse gas (GHG) emissions data. This interface will initially work with an existing database and industrial reporting system. Over time, the project may extend to database improvements or other parts of BC’s GHG data system. We are looking for a collaborative team, ready to learn, and passionate about providing solutions that will contribute to reducing industrial GHG emissions in BC and improving reporting to the public about our progress to our GHG targets.</p>
              </Col>
            </Row>
              <br/><br/>
            <Row>
                <Col md={6}>
                    <UserList/>
                </Col>
                <Col md={6}>
                    <SignIn/>
                </Col>
            </Row>
              <br/><br/>
            <Row>

            </Row>
          </Container>
        </React.Fragment>
    );
  }
}


export default Survey;