#!/bin/bash

dc=$(which docker-compose) # docker-compose command with full path

if [[ -x "$dc" ]]; then
    :
else
    echo "Please install Docker before run this command."
    exit 2
fi

rm="--rm" # To destroy a container

app="app" # describe $application service name from docker-compose.yml

app_name=`pwd | awk -F "/" '{ print $NF }'` # get project dir name

# define container name
app_container="${app_name}_${app}_1"

echoing() {
    echo "========================================================"
    echo "$1"
    echo "========================================================"
}

compose_init() {
    echoing "Building containers"
    dir="app"
    is_gem=false

    arg=$1

    if [[ $arg =~ --gem= ]]; then
      echo "options $arg"
      dir=${arg/--gem=/}
      is_gem=true
    fi

    echo "dir is setting by $dir"
    echo "is_gem is setting by $is_gem"

    sed -i -e s/belion/$dir/g docker-compose.yml
    rm docker-compose.yml-e
    sed -i -e s/belion/$dir/g Dockerfile
    rm Dockerfile-e

    $dc build --no-cache

    if "${is_gem}"; then
      bundle_cmd gem . -t --coc --mit
    fi
}

compose_up() {
    echoing "Create and start containers $*"
    $dc up -d "$1"
}

compose_down() {
    echoing "Stop and remove containers $*"
    $dc down $*
}

compose_build() {
    echoing "Build containers $*"
    $dc build $*
}

compose_start() {
    echoing "Start services $*"
    $dc start $*
}

compose_stop() {
    echoing "Stop services $*"
    $dc stop $*
}

compose_restart() {
    echoing "Restart services $*"
    $dc restart $*
}

compose_ps() {
    echoing "Showing running containers"
    $dc ps
}

logs() {
    echoing "Logs $*"
    $dc logs -f $1
}

invoke_bash() {
    $dc run $rm -u root $1 bash
}

invoke_run() {
    $dc run $rm $*
}

run_app() {
    invoke_run $app $*
}

ruby_cmd() {
    bundle_exec ruby $*
}

rake_cmd() {
    bundle_exec rake $*
}

rspec_cmd() {
    bundle_exec rspec $*
}

bundle_cmd() {
    run_app bundle $*
}

bundle_exec() {
    run_app bundle exec $*
}

rubocop_cmd() {
    bundle_exec rubocop $*
}

cmd=$1
shift
case "$cmd" in
    init)
        compose_init $* && exit 0
        ;;
    ps)
        compose_ps && exit 0
        ;;
    up)
        compose_up $* && compose_ps && exit 0
        ;;
    build)
        compose_build $* && exit 0
        ;;
    start)
        compose_start $* && exit 0
        ;;
    stop)
        compose_stop $* && exit 0
        ;;
    restart)
        compose_restart $* && exit 0
        ;;
    down)
        compose_down $* && exit 0
        ;;
    logs)
        logs $*
        ;;
    bash)
        invoke_bash $*
        ;;
    run)
        invoke_run $*
        ;;
    ruby)
        ruby_cmd $*
        ;;
    rake)
        rake_cmd $*
        ;;
    rspec)
        rspec_cmd $*
        ;;
    bundle)
        bundle_cmd $*
        ;;
    rubocop)
        rubocop_cmd $*
        ;;
    *)
        read -d '' help <<-EOF
Usage: $0 command

Service:
  setup    Create new rails application
  init     Initialize backend services then run
  ps       Show status of services
  up       Create service containers and start backend services
  down     Stop backend services and remove service containers
  start    Start services
  stop     Stop services
  logs     [options] default: none. View output from containers
  bash     [service] invoke bash
  run      [service] [command] run command in given container

App:
  ruby     [args] Run ruby command in application container
  rake     [args] Run rake command in application container
  rspec    [args] Run rspec command in application container
  bundle   [args] Run bundle command in application container
  rubocop  [args] Run rubocop
EOF
        echo "$help"
        exit 2
        ;;
esac
