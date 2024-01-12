package petstore

import (
	"context"
	"github.com/hashicorp/go-multierror"
	"github.com/hashicorp/terraform-plugin-sdk/v2/diag"
	"github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema"
	sdk "github.com/heiden-deng/go-petstore"
	"log"
)

func DataSourcePet() *schema.Resource {
	return &schema.Resource{
		ReadContext: dataSourcePetRead,

		Schema: map[string]*schema.Schema{
			"id": {
				Type:     schema.TypeString,
				Required: true,
			},
			"name": {
				Type:     schema.TypeString,
				Optional: true,
			},
			"species": {
				Type:     schema.TypeString,
				Optional: true,
				Computed: true,
			},
			"age": {
				Type:     schema.TypeInt,
				Optional: true,
				Computed: true,
			},
		},
	}
}

func dataSourcePetRead(_ context.Context, d *schema.ResourceData, meta interface{}) diag.Diagnostics {
	conn := meta.(*sdk.Client)
	id := d.Get("id").(string)
	log.Printf("pet id=%s", id)

	pet, err := conn.Pets.Read(id)
	if err != nil {
		return diag.Errorf("unable to get pet object :[%s] %s", id, err)
	}
	//return diag.Errorf("pet name=%s", pet.Name)
	log.Printf("pet name=%s", pet.Name)
	//diag.Errorf("pet name=%s", pet.Name)
	d.SetId(id)
	mErr := multierror.Append(nil,
		d.Set("id", pet.ID),
		d.Set("name", pet.Name),
		d.Set("species", pet.Species),
		d.Set("age", pet.Age),
	)
	if err = mErr.ErrorOrNil(); err != nil {
		return diag.Errorf("error setting node fields: %s", err)
	}

	return nil
}
