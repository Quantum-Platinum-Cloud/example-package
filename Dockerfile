FROM golang@sha256:9349ed889adb906efa5ebc06485fe1b6a12fb265a01c9266a137bb1352565560 as builder

WORKDIR /app
COPY . /app

RUN go get -d -v

# Statically compile our app for use in a distroless container
RUN CGO_ENABLED=0 go build -ldflags="-w -s" -v -o app .

# A distroless container image with some basics like SSL certificates
# https://github.com/GoogleContainerTools/distroless
FROM gcr.io/distroless/static@sha256:21d3f84a4f37c36199fd07ad5544dcafecc17776e3f3628baf9a57c8c0181b3f

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]
