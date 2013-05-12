From: Leonardo Chiquitto <leonardo.lists@gmail.com>
Subject: Re: get_proximity() crashes on interfaces with no addresses
Date: Sun, 12 May 2013 20:26:45 +0200
Message-ID: <CAEySpB5ugEzVKNpZPy1PR5baeoN-Z1auET0W0M_OoQwSjTPVtA@mail.gmail.com>
References: <518FB9DC.3000304@nazar.ca>
Mime-Version: 1.0
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=Y9JcgN/eqXjABGvKxhSK3df50jqrDvr9uQjEigpRkLY=;
        b=a4E5aihuowh9pkV9OBfgPJNYPtDOPms6Rrr18qErUFQeLHTVh1tKUr+7SYqdFRiRO5
         IbSYAWeHy2810vxxTQy+rTSqZeVDmDk3UeHgQ1r2pdetwqQfGL7+EpEyV6XNw2KHS3eb
         sdG9ULTMQpaaBE7a7dVQygAT5y8ZwYvaayQKuh4R36SHoEc0hnBOvtqhFe/n3Ar+Y9Ly
         FGjlN7aGSUSHO20ZOvTnIWzH8W/OIjgFfbrICfM0YUgPj7JC/umuqSB8J2noUjVl9JOV
         Gac4szuyflC8nkma6pLNARLJNUSWf0ijke10X+YqIqFLa1PgpiRBaZn3gxuU4yDBNCJH
         zlHQ==
In-Reply-To: <518FB9DC.3000304@nazar.ca>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Doug Nazar <nazard@nazar.ca>
Cc: autofs@vger.kernel.org

On Sun, May 12, 2013 at 5:48 PM, Doug Nazar <nazard@nazar.ca> wrote:
> Since commit aa6f7793 [autofs-5.0.7 - fix ipv6 proximity calculation] uses
> getifaddrs however it crashes on interfaces with no addresses. Fix the NULL
> check to ignore interfaces with no addresses.

Hi,

Your patch removes the check on ifa_addr->sa_data. I'm wondering if
it's possible to have a valid ifa_addr and a NULL sa_data. Do you know?
Maybe it's safer to just test both:

 		if (this->ifa_flags & IFF_POINTOPOINT ||
		    this->ifa_addr == NULL ||
		    this->ifa_addr->sa_data == NULL) {
 			this = this->ifa_next;
 			continue;
 		}

> Should it also check for the IFF_UP flag?

I think it makes sense to test it.

Thanks,
Leonardo
