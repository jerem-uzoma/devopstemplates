FROM golang:alpine AS build-envRUN mkdir /go/src/app && apk update && apk add gitADD main.go /go/src/app/WORKDIR /go/src/appRUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o app .FROM scratchWORKDIR /appCOPY --from=build-env /go/src/app/app .ENTRYPOINT [ "./app" ]