module StripeService 
    module_function 
    
    def create_checkout_session(user, product, success_url:, cancel_url:, appointment_online:, appointment_time:, appointment_date:, appointment_first:, appointment_user_id:, appointment_professional_id:, appointment_autentication_token:)
        session = Stripe::Checkout::Session.create({
            success_url: "#{success_url}?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_url,
            payment_method_types: ["card"],
            client_reference_id: product.id,
            allow_promotion_codes: true,
            mode: "payment",
            metadata: {
                appointment_online: appointment_online,
                appointment_time: appointment_time,
                appointment_date: appointment_date,
                appointment_first: appointment_first,
                appointment_user_id: appointment_user_id,
                appointment_professional_id: appointment_professional_id,
                appointment_autentication_token: appointment_autentication_token
            },
            line_items: [{
                price_data: {
                    currency: "mxn",
                    unit_amount: product.amount_in_cents,
                    product_data: {
                    name: product.name,
                    description: product.description,
                    metadata: {
                        userId: user.id,
                        productId: product.id,
                    },
                },
            },
            quantity: 1,
            }], 
            payment_intent_data: {
                capture_method: "manual" # Establecer el método de captura manual para la autorización de pago
            }
        })
        success_url_with_session_id = success_url.gsub("{CHECKOUT_SESSION_ID}", session.id)
        StripeServiceResponse.new(
            status: "ok",
            error: nil,
            url: session.url,
            session_id: session.id,
            success_url: success_url_with_session_id,
        )
        rescue => e
            StripeServiceResponse.new(
            status: "error",
            error: e.message
        )
    end
    
    def capture_payment(id)
        payment_intent = Stripe::PaymentIntent.capture(id)
        StripeResponse.new(success: true, payment_intent: payment_intent)
    rescue Stripe::StripeError => e
        StripeResponse.new(success: false, error: e.message)
    end
    
    def cancel_payment_authorization(id)
        payment_intent = Stripe::PaymentIntent.cancel(id)
        StripeResponse.new(success: true, payment_intent: id)
    rescue Stripe::StripeError => e
        StripeResponse.new(success: false, error: e.message)
    end
    
    class StripeServiceResponse < Struct.new(:status, :error, :url, :session_id, :success_url, keyword_init: true)
        def success?
            status == "ok"
        end
    end
    
    class StripeResponse < Struct.new(:success, :error, :payment_intent, keyword_init: true)
        def success?
            success
        end
    end
end