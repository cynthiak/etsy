class ChangeCustomerFieldsToString < ActiveRecord::Migration
  def up
    #### COLUMN #####################################
    add_column :customers, :temp_first_name, :string
    add_column :customers, :temp_last_name, :string
    add_column :customers, :temp_etsy_username, :string
    add_column :customers, :temp_email, :string
    add_column :customers, :temp_source, :string
    add_column :customers, :temp_ship_name, :string
    add_column :customers, :temp_ship_address1, :string
    add_column :customers, :temp_ship_address2, :string
    add_column :customers, :temp_ship_city, :string
    add_column :customers, :temp_ship_state, :string
    add_column :customers, :temp_ship_zipcode, :string
    add_column :customers, :temp_ship_country, :string


    Customer.find_each do |customer|
      #### COLUMN #####################################
      temp_first_name = customer.first_name
      if customer.first_name.to_s.length > 255
        temp_first_name = customer.first_name[0,254]
      end
      customer.update_column(:temp_first_name, temp_first_name)
      #### COLUMN #####################################
      temp_last_name = customer.last_name
      if customer.last_name.to_s.length > 255
        temp_last_name = customer.last_name[0,254]
      end
      customer.update_column(:temp_last_name, temp_last_name)
      #### COLUMN #####################################
      temp_etsy_username = customer.etsy_username
      if customer.etsy_username.to_s.length > 255
        temp_etsy_username = customer.etsy_username[0,254]
      end
      customer.update_column(:temp_etsy_username, temp_etsy_username)
      #### COLUMN #####################################
      temp_email = customer.email
      if customer.email.to_s.length > 255
        temp_email = customer.email[0,254]
      end
      customer.update_column(:temp_email, temp_email)
      #### COLUMN #####################################
      temp_source = customer.source
      if customer.source.to_s.length > 255
        temp_source = customer.source[0,254]
      end
      customer.update_column(:temp_source, temp_source)
      #### COLUMN #####################################
      temp_ship_name = customer.ship_name
      if customer.ship_name.to_s.length > 255
        temp_ship_name = customer.ship_name[0,254]
      end
      customer.update_column(:temp_ship_name, temp_ship_name)
      #### COLUMN #####################################
      temp_ship_address1 = customer.ship_address1
      if customer.ship_address1.to_s.length > 255
        temp_ship_address1 = customer.ship_address1[0,254]
      end
      customer.update_column(:temp_ship_address1, temp_ship_address1)
      #### COLUMN #####################################
      temp_ship_address2 = customer.ship_address2
      if customer.ship_address2.to_s.length > 255
        temp_ship_address2 = customer.ship_address2[0,254]
      end
      customer.update_column(:temp_ship_address2, temp_ship_address2)
      #### COLUMN #####################################
      temp_ship_city = customer.ship_city
      if customer.ship_city.to_s.length > 255
        temp_ship_city = customer.ship_city[0,254]
      end
      customer.update_column(:temp_ship_city, temp_ship_city)
      #### COLUMN #####################################
      temp_ship_state = customer.ship_state
      if customer.ship_state.to_s.length > 255
        temp_ship_state = customer.ship_state[0,254]
      end
      customer.update_column(:temp_ship_state, temp_ship_state)
      #### COLUMN #####################################
      temp_ship_zipcode = customer.ship_zipcode
      if customer.ship_zipcode.to_s.length > 255
        temp_ship_zipcode = customer.ship_zipcode[0,254]
      end
      customer.update_column(:temp_ship_zipcode, temp_ship_zipcode)
      #### COLUMN #####################################
      temp_ship_country = customer.ship_country
      if customer.ship_country.to_s.length > 255
        temp_ship_country = customer.ship_country[0,254]
      end
      customer.update_column(:temp_ship_country, temp_ship_country)
    end
    remove_column :customers, :first_name
    remove_column :customers, :last_name
    remove_column :customers, :etsy_username
    remove_column :customers, :email
    remove_column :customers, :source
    remove_column :customers, :ship_name
    remove_column :customers, :ship_address1
    remove_column :customers, :ship_address2
    remove_column :customers, :ship_city
    remove_column :customers, :ship_state
    remove_column :customers, :ship_zipcode
    remove_column :customers, :ship_country

    rename_column :customers, :temp_first_name, :first_name
    rename_column :customers, :temp_last_name, :last_name
    rename_column :customers, :temp_etsy_username, :etsy_username
    rename_column :customers, :temp_email, :email
    rename_column :customers, :temp_source, :source
    rename_column :customers, :temp_ship_name, :ship_name
    rename_column :customers, :temp_ship_address1, :ship_address1
    rename_column :customers, :temp_ship_address2, :ship_address2
    rename_column :customers, :temp_ship_city, :ship_city  
    rename_column :customers, :temp_ship_state, :ship_state
    rename_column :customers, :temp_ship_zipcode, :ship_zipcode
    rename_column :customers, :temp_ship_country, :ship_country
  end

  def down
    change_column :customers, :first_name, :text
    change_column :customers, :last_name, :text
    change_column :customers, :etsy_username, :text
    change_column :customers, :email, :text
    change_column :customers, :source, :text
    change_column :customers, :ship_name, :text
    change_column :customers, :ship_address1, :text
    change_column :customers, :ship_address2, :text
    change_column :customers, :ship_city, :text
    change_column :customers, :ship_state, :text
    change_column :customers, :ship_zipcode, :text
    change_column :customers, :ship_country, :text
  end
end
