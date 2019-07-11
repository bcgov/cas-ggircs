import React , { Component } from 'react'
import { QueryRenderer, graphql } from 'react-relay';
import SignIn from '../components/SignIn'
import initEnvironment from '../lib/createRelayEnvironment'
import {Col, Container, Row} from "react-bootstrap";
import Header from '../components/Header'
import UserList from "../components/UserList";


class Index extends Component {
  static displayName = `Index`

  render(props) {
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
              <iframe
                  src="https://metabase-wksv3k-dev.pathfinder.gov.bc.ca/public/question/2b7ec16a-5793-4788-a2da-0fe08a100e55"
                  frameBorder="0"
                  width="100%"
                  height="600"
                  allowTransparency
              ></iframe>
            </Row>
          </Container>
        </React.Fragment>
    );
  }
}


export default Index;