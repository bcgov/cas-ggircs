import React, { useEffect, useState } from "react";
import { EcccFile } from "types";
import { Row, Col, ListGroup } from "react-bootstrap";
import FileDetails from "./FileDetails";

const FileList: React.FunctionComponent = () => {
  const [selectedFile, setSelectedFile] = useState<EcccFile>(null);
  const [files, setFiles] = useState<EcccFile[]>([]);

  useEffect(() => {
    (async () => {
      const filesResponse = await fetch("/api/eccc/files");
      setFiles(await filesResponse.json());
    })();
  }, []);

  return (
    <Row>
      <Col md={4}>
        <h2>Uploaded Files</h2>
        <div className="scrollable">
          <ListGroup>
            {files.map((file) => (
              <ListGroup.Item
                action
                onClick={() => setSelectedFile(file)}
                active={selectedFile && selectedFile.name === file.name}
                key={file.name}
              >
                {file.name}
              </ListGroup.Item>
            ))}
          </ListGroup>
        </div>
      </Col>
      <Col md={8}>
        {selectedFile && <FileDetails ecccFile={selectedFile} />}
      </Col>
      <style jsx>
        {`
          h2 {
            font-size: 20px;
          }
          .scrollable {
            max-height: calc(100vh - 400px);
            overflow-y: auto;
          }
        `}
      </style>
    </Row>
  );
};

export default FileList;
