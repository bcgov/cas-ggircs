import React, { useEffect, useState } from "react";
import { EcccFile } from "next-env";
import { ListGroup } from "react-bootstrap";
import LoadingSpinner from "components/LoadingSpinner";
import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import { faFileDownload } from "@fortawesome/free-solid-svg-icons";

interface Props {
  ecccFile: EcccFile;
}

const FileDetails: React.FunctionComponent<Props> = ({ ecccFile }) => {
  const [fileContents, setFileContents] = useState<string[]>(null);

  useEffect(() => {
    setFileContents(null);
    (async () => {
      const resp = await fetch(`/api/eccc/files/${ecccFile.name}`);
      const respBody = await resp.json();
      if (respBody.zip_content_list) {
        setFileContents(
          respBody.zip_content_list.filter(
            (fileName) => !fileName.endsWith("/")
          )
        );
      } else {
        setFileContents([]);
      }
    })();
  }, [ecccFile]);

  return (
    <>
      <div className="details">
        <h3>{ecccFile.name}</h3>
        <span>{Math.round(ecccFile.size)}MB</span>
        <span>
          Imported from ECCC on {new Date(ecccFile.created_at).toDateString()}
        </span>
      </div>
      <div className="scrollable">
        {!fileContents && <LoadingSpinner />}
        {fileContents && (
          <ListGroup>
            {fileContents.map((fileName) => (
              <ListGroup.Item key={fileName}>
                <div className="file-row">
                  <span>{fileName}</span>
                  <a
                    href={`/api/eccc/files/${
                      ecccFile.name
                    }/download?filename=${encodeURIComponent(fileName)}`}
                    target="_blank"
                    rel="noreferrer"
                  >
                    <FontAwesomeIcon icon={faFileDownload} title="Download" />
                  </a>
                </div>
              </ListGroup.Item>
            ))}
          </ListGroup>
        )}
      </div>
      <style jsx>
        {`
          h3 {
            font-size: 20px;
          }
          .scrollable {
            max-height: max(calc(100vh - 400px), 400px);
            overflow-y: auto;
          }
          .details,
          .file-row {
            display: flex;
            justify-content: space-between;
          }
        `}
      </style>
    </>
  );
};

export default FileDetails;
