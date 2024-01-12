package main

import (
	"github.com/hashicorp/terraform-plugin-sdk/v2/plugin"
	"github.com/heiden-deng/terraform-provider-petstore/petstore"
	"log"
)

func main() {
	log.SetFlags(log.Flags() &^ (log.Ldate | log.Ltime))
	plugin.Serve(&plugin.ServeOpts{
		ProviderFunc: petstore.Provider})
}
