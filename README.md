# Crazy Bites — Rasca y Gana seguro

Este paquete incluye:
- `index.html`: página pública con raspadita.
- `admin.html`: pantalla para validar/canjear cupones.
- `supabase/schema.sql`: tablas, restricciones e índices.
- `supabase/functions/issue-prize/index.ts`: asigna un premio en el servidor.
- `supabase/functions/redeem-prize/index.ts`: canjea cada cupón una sola vez.
- `config.js`: configuración pública del proyecto.

## Importante
No existe una protección 100% imposible de vulnerar. Esta versión evita que el navegador elija/modifique premios y que un mismo cupón se canjee dos veces. Para reducir múltiples intentos por una misma persona exige inicio de sesión con correo verificado. Alguien podría intentar crear varias cuentas; para promociones de mayor valor conviene añadir verificación telefónica y límites adicionales.

## Publicación gratis
1. Crea un proyecto en https://supabase.com/ (el plan gratis sirve para empezar).
2. En SQL Editor, ejecuta `supabase/schema.sql`.
3. En Project Settings → API copia Project URL y anon/public key en `config.js`.
4. Instala Supabase CLI en una computadora o usa el flujo de despliegue disponible en tu entorno:
   - `supabase login`
   - `supabase link --project-ref TU_PROJECT_REF`
   - `supabase secrets set SUPABASE_URL=... SUPABASE_SERVICE_ROLE_KEY=... ADMIN_REDEEM_KEY=...`
   - `supabase functions deploy issue-prize`
   - `supabase functions deploy redeem-prize --no-verify-jwt`
   La función de canje usa una clave privada larga; configura `ADMIN_REDEEM_KEY` con una contraseña aleatoria de al menos 32 caracteres.
   Nunca publiques la service role key ni el ADMIN_REDEEM_KEY en el HTML.
5. Publica `index.html`, `admin.html` y `config.js` en GitHub Pages, Netlify o Cloudflare Pages. Puedes empezar gratis.
6. En Supabase Auth configura la URL pública de tu sitio en Site URL y Redirect URLs.
7. Abre `admin.html` y escribe el `ADMIN_REDEEM_KEY` que configuraste como secreto del servidor para validar premios.
8. Cuando la web ya tenga una dirección pública definitiva, genera el QR con esa URL. El QR no se puede finalizar antes de saber la dirección final.

## Cambiar WhatsApp
En `config.js`, cambia `WHATSAPP_NUMBER` por tu número con código de país, solo dígitos. Para México: `52` + número, sin espacios ni signos. El valor incluido es el que se compartió para Crazy Bites: `522471746007`.

## Condiciones sugeridas
- Un premio por cuenta verificada durante la campaña.
- Cupón válido durante 7 días.
- El 100% se aplica solo a un producto participante con valor máximo de $50 MXN.
- No acumulable con otras promociones.
- El negocio debe verificar el cupón en `admin.html` antes de entregar el descuento.
