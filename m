From: Ian Kent <raven@themaw.net>
Subject: Re: [PATCH 9/9] autofs-5.0.7 - fix compilation of lookup_ldap.c
 without sasl
Date: Wed, 24 Jul 2013 18:20:18 +0800
Message-ID: <1374661218.2358.37.camel@perseus.fritz.box>
References: <20130724084903.3884.13354.stgit@perseus.fritz.box>
	 <20130724085402.3884.65664.stgit@perseus.fritz.box>
	 <CAF1ZMEc6UkK7+EZu_zccfHGZvk29e3txGxc+gUJ+Owmhq+pHEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=themaw.net; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=mesmtp;
	 bh=vv0YshUe2QpEx6BcQ09ipRlJTuo=; b=mhKot1JkJ9/3IZi6rFJ3YPTrIc/t
	S8qt59kw/dvhgkhcQpSk5nD1PP8iv99+2xeKwBVq0Wwhey8nKX4xRg8S4Frs9V3b
	0lEn3Aaf5iSdrVohINU5fhi0h2yhnppnvLVXAiH9bZYHQCF9pt3UXsiOoHkukl8t
	/or2S2ZosS+CloY=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:subject:from:to:cc:date
	:in-reply-to:references:content-type:mime-version
	:content-transfer-encoding; s=smtpout; bh=vv0YshUe2QpEx6BcQ09ipR
	lJTuo=; b=MF9AGTZgQCD0kasjAigwsMRcnG/91e6FVktxQ46NKDfBZIMV3V8Q5G
	Z5mdqplSxXzt5u8LAfERCZoK22ZQbWvx/6RGAL2DXmhe6DhTYF/DX4SSQaI2Jk0s
	QFmo1ps4K5INIFsDx0H9fL2dly3xqvyz7hvo4FBmz1hKFG0GmiTaU=
In-Reply-To: <CAF1ZMEc6UkK7+EZu_zccfHGZvk29e3txGxc+gUJ+Owmhq+pHEQ@mail.gmail.com>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Dennis Lan (dlan)" <dennis.yxun@gmail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>

On Wed, 2013-07-24 at 17:53 +0800, Dennis Lan (dlan) wrote:
> On Wed, Jul 24, 2013 at 4:54 PM, Ian Kent <raven@themaw.net> wrote:
> > From: Dustin Polke <DuPol@gmx.de>
> >
> > See https://bugs.gentoo.org/show_bug.cgi?id=361899 for more info.
> >
> > Edited by: Ian Kent <raven@themaw.net>
> > - fix parse_ldap_config() is needed by ldap but previously excluded.
> > - exclude other references to ctxt->extern_cert and ctxt->extern_key.
> > - prevent memory leak if present in config but not used.
> > - remove now unused set_env().
> > ---
> >  CHANGELOG             |    1 +
> >  include/lookup_ldap.h |    4 ++--
> >  lib/Makefile          |    4 ++++
> >  modules/Makefile      |    6 ++++--
> >  modules/lookup_ldap.c |   14 ++++++++++++--
> >  5 files changed, 23 insertions(+), 6 deletions(-)
> >
> > diff --git a/CHANGELOG b/CHANGELOG
> > index 42ea627..63d5aac 100644
> > --- a/CHANGELOG
> > +++ b/CHANGELOG
> > @@ -65,6 +65,7 @@
> >  - remove hard-coded STRIP variable.
> >  - use LIBS for link libraries.
> >  - unbundle NOTSTRIP from DEBUG so they dont depend on each other.
> > +- fix compilation of lookup_ldap.c without sasl.
> >
> >  25/07/2012 autofs-5.0.7
> >  =======================
> > diff --git a/include/lookup_ldap.h b/include/lookup_ldap.h
> > index 9a4ce73..f34c029 100644
> > --- a/include/lookup_ldap.h
> > +++ b/include/lookup_ldap.h
> > @@ -11,6 +11,8 @@
> >  #include <krb5.h>
> >  #endif
> >
> > +#include <libxml/tree.h>
> > +
> >  #include "list.h"
> >  #include "dclist.h"
> >
> > @@ -92,7 +94,6 @@ struct lookup_context {
> >  };
> >
> >
> > -#ifdef WITH_SASL
> >  #define LDAP_AUTH_CONF_FILE "test"
> >
> >  #define LDAP_TLS_DONT_USE      0
> > @@ -104,7 +105,6 @@ struct lookup_context {
> >  #define LDAP_AUTH_REQUIRED     0x0002
> >  #define LDAP_AUTH_AUTODETECT   0x0004
> >  #define LDAP_NEED_AUTH         (LDAP_AUTH_REQUIRED|LDAP_AUTH_AUTODETECT)
> > -#endif
> >
> >  #define LDAP_AUTH_USESIMPLE    0x0008
> >
> > diff --git a/lib/Makefile b/lib/Makefile
> > index 5418009..4a5b712 100644
> > --- a/lib/Makefile
> > +++ b/lib/Makefile
> > @@ -24,6 +24,10 @@ CFLAGS += -I../include -fPIC -D_GNU_SOURCE
> >  CFLAGS += -DAUTOFS_MAP_DIR=\"$(autofsmapdir)\"
> >  CFLAGS += -DAUTOFS_CONF_DIR=\"$(autofsconfdir)\"
> >
> > +ifeq ($(LDAP), 1)
> > +  CFLAGS += $(XML_FLAGS) $(XML_LIBS)
> > +endif
> > +
> >  .PHONY: all install clean
> >
> >  all: autofs.a
> > diff --git a/modules/Makefile b/modules/Makefile
> > index de01ebd..8610783 100644
> > --- a/modules/Makefile
> > +++ b/modules/Makefile
> > @@ -45,10 +45,12 @@ endif
> >  ifeq ($(LDAP), 1)
> >    SRCS += lookup_ldap.c
> >    MODS += lookup_ldap.so
> > +  LDAP_FLAGS += $(XML_FLAGS) -DLDAP_THREAD_SAFE
> > +  LIBLDAP += $(XML_LIBS)
> >    ifeq ($(SASL), 1)
> >      SASL_OBJ = cyrus-sasl.o cyrus-sasl-extern.o
> > -    LDAP_FLAGS += $(SASL_FLAGS) $(XML_FLAGS) $(KRB5_FLAGS) -DLDAP_THREAD_SAFE
> > -    LIBLDAP += $(LIBSASL) $(XML_LIBS) $(KRB5_LIBS)
> > +    LDAP_FLAGS += $(SASL_FLAGS) $(KRB5_FLAGS)
> > +    LIBLDAP += $(LIBSASL) $(KRB5_LIBS)
> >    endif
> >  endif
> >
> > diff --git a/modules/lookup_ldap.c b/modules/lookup_ldap.c
> > index a2bfafd..904cc21 100644
> > --- a/modules/lookup_ldap.c
> > +++ b/modules/lookup_ldap.c
> > @@ -66,6 +66,7 @@ struct ldap_search_params {
> >
> >  static int decode_percent_hack(const char *, char **);
> >
> > +#ifdef HAVE_SASL
> As I checked file of include/config.h (generated by ./configure)
> there is only "WITH_SASL", but no "HAVE_SASL"

Right, thanks for mentioning it, I'll check that when I work though this
patch. I haven't actually looked closely at it since I moved to to "will
commit" status, and it definitely needs to be reviewed.

> 
> 
> >  static int set_env(unsigned logopt, const char *name, const char *val)
> >  {
> >         int ret = setenv(name, val, 1);
> > @@ -75,6 +76,7 @@ static int set_env(unsigned logopt, const char *name, const char *val)
> >         }
> >         return 1;
> >  }
> > +#endif
> >
> >  #ifndef HAVE_LDAP_CREATE_PAGE_CONTROL
> >  int ldap_create_page_control(LDAP *ldap, ber_int_t pagesize,
> > @@ -585,10 +587,12 @@ static LDAP *do_connect(unsigned logopt, const char *uri, struct lookup_context
> >  {
> >         LDAP *ldap;
> >
> > +#ifdef HAVE_SASL
> same here
> 
> >         if (ctxt->extern_cert && ctxt->extern_key) {
> >                 set_env(logopt, ENV_LDAPTLS_CERT, ctxt->extern_cert);
> >                 set_env(logopt, ENV_LDAPTLS_KEY, ctxt->extern_key);
> >         }
> > +#endif
> >
> >         ldap = init_ldap_connection(logopt, uri, ctxt);
> >         if (ldap) {
> > @@ -791,7 +795,6 @@ find_server:
> >         return ldap;
> >  }
> >
> > -#ifdef WITH_SASL
> >  int get_property(unsigned logopt, xmlNodePtr node, const char *prop, char **value)
> >  {
> >         xmlChar *ret;
> > @@ -812,6 +815,7 @@ int get_property(unsigned logopt, xmlNodePtr node, const char *prop, char **valu
> >         return 0;
> >  }
> >
> > +#ifdef WITH_SASL
> >  /*
> >   *  For plain text, login and digest-md5 authentication types, we need
> >   *  user and password credentials.
> > @@ -824,6 +828,7 @@ int authtype_requires_creds(const char *authtype)
> >                 return 1;
> >         return 0;
> >  }
> > +#endif
> >
> >  /*
> >   *  Returns:
> > @@ -1056,6 +1061,7 @@ auth_fail:
> >                 }
> >         } else if (auth_required == LDAP_AUTH_REQUIRED &&
> >                   (authtype && !strncmp(authtype, "EXTERNAL", 8))) {
> > +#ifdef WITH_SASL
> >                 ret = get_property(logopt, root, "external_cert",  &extern_cert);
> >                 ret |= get_property(logopt, root, "external_key",  &extern_key);
> >                 /*
> > @@ -1074,6 +1080,7 @@ auth_fail:
> >                         if (extern_key)
> >                                 free(extern_key);
> >                 }
> > +#endif
> >         }
> >
> >         /*
> > @@ -1094,8 +1101,10 @@ auth_fail:
> >         ctxt->secret = secret;
> >         ctxt->client_princ = client_princ;
> >         ctxt->client_cc = client_cc;
> > +#ifdef WITH_SASL
> >         ctxt->extern_cert = extern_cert;
> >         ctxt->extern_key = extern_key;
> > +#endif
> >
> >         debug(logopt, MODPREFIX
> >               "ldap authentication configured with the following options:");
> > @@ -1127,7 +1136,6 @@ out:
> >
> >         return ret;
> >  }
> > -#endif
> >
> >  /*
> >   *  Take an input string as specified in the master map, and break it
> > @@ -1390,10 +1398,12 @@ static void free_context(struct lookup_context *ctxt)
> >                 defaults_free_searchdns(ctxt->sdns);
> >         if (ctxt->dclist)
> >                 free_dclist(ctxt->dclist);
> > +#ifdef HAVE_SASL
> same here
> 
> >         if (ctxt->extern_cert)
> >                 free(ctxt->extern_cert);
> >         if (ctxt->extern_key)
> >                 free(ctxt->extern_key);
> > +#endif
> >         free(ctxt);
> >
> >         return;
> >


