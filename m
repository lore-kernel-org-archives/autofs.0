From: Tigran Aivazian <aivazian.tigran-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/8] fs: add some missing ctime updates
Date: Mon, 12 Jun 2023 12:01:52 +0100
Message-ID: <CAK+_RLkoAX_n-PPYv9zEpitbMk3DxZx2EWYaKT7YKH_wEys+ew@mail.gmail.com>
References: <20230612104524.17058-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="000000000000a1886905fded7cd8"
Return-path: <apparmor-bounces-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686571323; x=1689163323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gIeNho+iq7fIieD/uaaC3C3MZzDx4EtnWzlRBh9eZ+o=;
 b=a7THlsmPARBVuXhzhi14HAL+cHx3H+b+HMY+KwHAWyVnB306A74iDPjXZKE6csTPsB
 B+bdDGNFHHk9WPYPc5NGsEgxYafyt0qHlcvElGOhaJ9+XsIwsZ5HpsS7X0DD+t5FsLmE
 2WWwj78e6erno17rzYlLGGBNVEc2S3SxyKgJtMuemuPyPCM2mcfoatNj6uwBYUq7nc3w
 0yRPEUTfQmqBSB2Uz4oA4ZFAoHa0h9ySH/tWWRuNXOkQ4n4OH+06yQRuZTrmjCxQa1nG
 k0NQI/qkhkmROAtHkSDiTy2KULtdr5U9FDMSqTzxip8LEa7WEHAjTzbOFR8O5WolEZ4B
 NuLg==
In-Reply-To: <20230612104524.17058-1-jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/apparmor>,
 <mailto:apparmor-request-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/apparmor>
List-Post: <mailto:apparmor-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org>
List-Help: <mailto:apparmor-request-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/apparmor>,
 <mailto:apparmor-request-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org?subject=subscribe>
Errors-To: apparmor-bounces-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org
Sender: "AppArmor" <apparmor-bounces-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org>
To: Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-efi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Ruihan Li <lrh2000-NXN67KNX7eEnDS1+zs4M5A@public.gmane.org>, Ard Biesheuvel <ardb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Kent <raven-PKsaG3nR2I+sTnJN9+BGXg@public.gmane.org>, Paulo Alcantara <pc-mxznQ8SDR6Dby3iVrkZq2A@public.gmane.org>, linux-cifs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Moore <paul-r2n+y4ga6xFZroRs9YW3xA@public.gmane.org>, Ritu Agarwal <rituagar-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Namjae Jeon <linkinjeon-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Serge E. Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shyam Prasad N <sprasad-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, autofs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, apparmor-nLRlyDuq1AZFpShjVBNYrg@public.gmane.org, Tom Talpey <tom-CLs1Zie5N5HQT0dZR+AlfA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Suren Baghdasaryan <surenb-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Christian Brauner <brauner-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, samba-technical-w/Ol4Ecudpkbz5eF0SucJw@public.gmane.org

--000000000000a1886905fded7cd8
Content-Type: text/plain; charset="UTF-8"

Hi Jeff and all,

On Mon, 12 Jun 2023 at 11:45, Jeff Layton <jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> None of these seem to be very crucial, but it would be nice if various
> maintainers could pick these up for v6.5. Please let me know if you do,
> or would rather I shepherd the patch upstream.
>

Yes, if you could shepherd the patch upstream, that would be great, as it's
been a very long time since I did any kernel hacking, and the patch
submission procedures must have changed in a decade or two :) Thank you!

Kind regards,
Tigran

--000000000000a1886905fded7cd8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jeff and all,</div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, 12 Jun 2023 at 11:45, Jeff La=
yton &lt;<a href=3D"mailto:jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org">jlayton-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org</a>&gt; w=
rote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">None of th=
ese seem to be very crucial, but it would be nice if various<br>
maintainers could pick these up for v6.5. Please let me know if you do,<br>
or would rather I shepherd the patch upstream.<br></blockquote><div><br></d=
iv><div>Yes, if you could shepherd the patch upstream, that would be great,=
 as it&#39;s been a very long time since I did any kernel hacking, and the =
patch submission procedures must have changed in a decade or two :) Thank y=
ou!</div><div><br></div><div>Kind regards,</div><div>Tigran</div></div></di=
v>

--000000000000a1886905fded7cd8--

