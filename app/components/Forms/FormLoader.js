import React, { Component } from 'react'
import * as Survey from "survey-react";
import "survey-react/survey.css";
import "survey-creator/survey-creator.css";
import {graphql, QueryRenderer} from "react-relay";
import initEnvironment from '../../lib/createRelayEnvironment'
const environment = initEnvironment();

class FormLoader extends Component {

    json = {
        elements: [
            { type: "text", name: "customerName", title: "Who is your name?", isRequired: true}
        ]
    };

    //Define a callback methods on survey complete
    onComplete(survey, options) {
        //Write survey results into database
        console.log("Survey results: " + JSON.stringify(survey.data));
    }

    createForm({error, props}) {
        console.log('form props', props);
        if (props) {
            let model = new Survey.Model(props.formJsonByRowId.formJson);
            return (<Survey.Survey model={model} onComplete={this.onComplete}/>)
        } else {
            return (<div>Loading...</div>)
        }
    }

    render() {
        return (
            <React.Fragment>
                <QueryRenderer
                    environment={environment}
                    query={graphql`
                        query FormLoaderQuery {
                          formJsonByRowId(rowId:2){
                            id
                            name
                            formJson
                          }
                        }
                    `}
                    render={this.createForm}
                />
            </React.Fragment>
        );

    }
}

export default FormLoader;