export type Json =
  | string
  | number
  | boolean
  | null
  | { [key: string]: Json | undefined }
  | Json[]

export type Database = {
  public: {
    Tables: {
      categories: {
        Row: {
          created_at: string
          icon: Json | null
          id: string
          name: string
          slug: string
        }
        Insert: {
          created_at?: string
          icon?: Json | null
          id?: string
          name: string
          slug: string
        }
        Update: {
          created_at?: string
          icon?: Json | null
          id?: string
          name?: string
          slug?: string
        }
        Relationships: []
      }
      contacts: {
        Row: {
          created_at: string
          email: string
          first_name: string
          id: string
          last_name: string
          message: string
          phone: string
          postal_code: string
          status: Database["public"]["Enums"]["contacts_status"]
          updated_at: string
        }
        Insert: {
          created_at?: string
          email: string
          first_name: string
          id?: string
          last_name: string
          message: string
          phone: string
          postal_code: string
          status?: Database["public"]["Enums"]["contacts_status"]
          updated_at?: string
        }
        Update: {
          created_at?: string
          email?: string
          first_name?: string
          id?: string
          last_name?: string
          message?: string
          phone?: string
          postal_code?: string
          status?: Database["public"]["Enums"]["contacts_status"]
          updated_at?: string
        }
        Relationships: []
      }
      installations: {
        Row: {
          created_at: string
          description: string | null
          id: string
          images: Json | null
          productId: string | null
          title: string | null
        }
        Insert: {
          created_at?: string
          description?: string | null
          id?: string
          images?: Json | null
          productId?: string | null
          title?: string | null
        }
        Update: {
          created_at?: string
          description?: string | null
          id?: string
          images?: Json | null
          productId?: string | null
          title?: string | null
        }
        Relationships: [
          {
            foreignKeyName: "installations_productId_fkey"
            columns: ["productId"]
            isOneToOne: false
            referencedRelation: "products"
            referencedColumns: ["id"]
          },
        ]
      }
      orders: {
        Row: {
          billingAddress: Json
          companyName: string | null
          created_at: string
          deliveryDate: string | null
          deliveryShopId: string | null
          email: string
          firstName: string
          id: string
          lastName: string
          paymentDate: string | null
          paymentProvider: string | null
          paymentStatus: string
          phoneNumber: string
          products: Json
          status: string
        }
        Insert: {
          billingAddress: Json
          companyName?: string | null
          created_at?: string
          deliveryDate?: string | null
          deliveryShopId?: string | null
          email: string
          firstName?: string
          id?: string
          lastName?: string
          paymentDate?: string | null
          paymentProvider?: string | null
          paymentStatus?: string
          phoneNumber: string
          products: Json
          status?: string
        }
        Update: {
          billingAddress?: Json
          companyName?: string | null
          created_at?: string
          deliveryDate?: string | null
          deliveryShopId?: string | null
          email?: string
          firstName?: string
          id?: string
          lastName?: string
          paymentDate?: string | null
          paymentProvider?: string | null
          paymentStatus?: string
          phoneNumber?: string
          products?: Json
          status?: string
        }
        Relationships: []
      }
      pages: {
        Row: {
          content: Json
          created_at: string
          id: string
          slug: string
          title: string
          updated_at: string
        }
        Insert: {
          content?: Json
          created_at?: string
          id?: string
          slug: string
          title: string
          updated_at?: string
        }
        Update: {
          content?: Json
          created_at?: string
          id?: string
          slug?: string
          title?: string
          updated_at?: string
        }
        Relationships: []
      }
      products: {
        Row: {
          categoryId: string
          created_at: string
          description: string | null
          fromPrice: number | null
          id: string
          mainImage: Json | null
          name: string
          onHomepage: boolean
          price: number | null
          quantity: number | null
          shopId: string | null
          slug: string
          variants: Json | null
          variantsImages: Json | null
        }
        Insert: {
          categoryId: string
          created_at?: string
          description?: string | null
          fromPrice?: number | null
          id?: string
          mainImage?: Json | null
          name: string
          onHomepage?: boolean
          price?: number | null
          quantity?: number | null
          shopId?: string | null
          slug: string
          variants?: Json | null
          variantsImages?: Json | null
        }
        Update: {
          categoryId?: string
          created_at?: string
          description?: string | null
          fromPrice?: number | null
          id?: string
          mainImage?: Json | null
          name?: string
          onHomepage?: boolean
          price?: number | null
          quantity?: number | null
          shopId?: string | null
          slug?: string
          variants?: Json | null
          variantsImages?: Json | null
        }
        Relationships: [
          {
            foreignKeyName: "products_categoryId_fkey"
            columns: ["categoryId"]
            isOneToOne: false
            referencedRelation: "categories"
            referencedColumns: ["id"]
          },
          {
            foreignKeyName: "products_shopId_fkey"
            columns: ["shopId"]
            isOneToOne: false
            referencedRelation: "shops"
            referencedColumns: ["id"]
          },
        ]
      }
      shops: {
        Row: {
          address: string | null
          city: string | null
          country: string | null
          created_at: string | null
          email: string | null
          googleMapsUrl: string | null
          id: string
          image: Json | null
          openHours: Json | null
          phoneNumber: string | null
          postalCode: string | null
        }
        Insert: {
          address?: string | null
          city?: string | null
          country?: string | null
          created_at?: string | null
          email?: string | null
          googleMapsUrl?: string | null
          id?: string
          image?: Json | null
          openHours?: Json | null
          phoneNumber?: string | null
          postalCode?: string | null
        }
        Update: {
          address?: string | null
          city?: string | null
          country?: string | null
          created_at?: string | null
          email?: string | null
          googleMapsUrl?: string | null
          id?: string
          image?: Json | null
          openHours?: Json | null
          phoneNumber?: string | null
          postalCode?: string | null
        }
        Relationships: []
      }
      users: {
        Row: {
          created_at: string
          id: string
          role: Database["public"]["Enums"]["user_role"]
          updated_at: string
        }
        Insert: {
          created_at?: string
          id: string
          role?: Database["public"]["Enums"]["user_role"]
          updated_at?: string
        }
        Update: {
          created_at?: string
          id?: string
          role?: Database["public"]["Enums"]["user_role"]
          updated_at?: string
        }
        Relationships: [
          {
            foreignKeyName: "users_id_fkey"
            columns: ["id"]
            isOneToOne: true
            referencedRelation: "users"
            referencedColumns: ["id"]
          },
        ]
      }
    }
    Views: {
      [_ in never]: never
    }
    Functions: {
      is_admin_authenticated_user: {
        Args: Record<PropertyKey, never>
        Returns: boolean
      }
      is_editor_authenticated_user: {
        Args: Record<PropertyKey, never>
        Returns: boolean
      }
      is_viewer_authenticated_user: {
        Args: Record<PropertyKey, never>
        Returns: boolean
      }
      is_visitor_authenticated_user: {
        Args: Record<PropertyKey, never>
        Returns: boolean
      }
    }
    Enums: {
      contacts_status: "NEW" | "IN_PROGRESS" | "CLOSED"
      user_role: "ADMIN" | "EDITOR" | "VIEWER" | "VISITOR"
    }
    CompositeTypes: {
      [_ in never]: never
    }
  }
}

type PublicSchema = Database[Extract<keyof Database, "public">]

export type Tables<
  PublicTableNameOrOptions extends
    | keyof (PublicSchema["Tables"] & PublicSchema["Views"])
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
        Database[PublicTableNameOrOptions["schema"]]["Views"])
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? (Database[PublicTableNameOrOptions["schema"]]["Tables"] &
      Database[PublicTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : PublicTableNameOrOptions extends keyof (PublicSchema["Tables"] &
        PublicSchema["Views"])
    ? (PublicSchema["Tables"] &
        PublicSchema["Views"])[PublicTableNameOrOptions] extends {
        Row: infer R
      }
      ? R
      : never
    : never

export type TablesInsert<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Insert: infer I
      }
      ? I
      : never
    : never

export type TablesUpdate<
  PublicTableNameOrOptions extends
    | keyof PublicSchema["Tables"]
    | { schema: keyof Database },
  TableName extends PublicTableNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicTableNameOrOptions["schema"]]["Tables"]
    : never = never,
> = PublicTableNameOrOptions extends { schema: keyof Database }
  ? Database[PublicTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : PublicTableNameOrOptions extends keyof PublicSchema["Tables"]
    ? PublicSchema["Tables"][PublicTableNameOrOptions] extends {
        Update: infer U
      }
      ? U
      : never
    : never

export type Enums<
  PublicEnumNameOrOptions extends
    | keyof PublicSchema["Enums"]
    | { schema: keyof Database },
  EnumName extends PublicEnumNameOrOptions extends { schema: keyof Database }
    ? keyof Database[PublicEnumNameOrOptions["schema"]]["Enums"]
    : never = never,
> = PublicEnumNameOrOptions extends { schema: keyof Database }
  ? Database[PublicEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : PublicEnumNameOrOptions extends keyof PublicSchema["Enums"]
    ? PublicSchema["Enums"][PublicEnumNameOrOptions]
    : never

