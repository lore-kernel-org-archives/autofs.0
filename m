From: mike@waychison.com
Subject: Re: [PATCH/RFC 1/2] rpcproxyd
Date: Mon, 14 Mar 2005 12:34:58 -0500 (EST)
Message-ID: <48275.66.11.176.22.1110821698.squirrel@webmail1.hrnoc.net>
References: <37086.66.11.176.22.1110228763.squirrel@webmail1.hrnoc.net>
    <37093.66.11.176.22.1110228819.squirrel@webmail1.hrnoc.net>
    <20050314105249.GH14815@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050314105249.GH14815@suse.de>
Sender: nfs-admin@lists.sourceforge.net
Errors-To: nfs-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <autofs.vger.kernel.org>
List-Post: <mailto:nfs@lists.sourceforge.net>
List-Help: <mailto:nfs-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/nfs>,
	<mailto:nfs-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=nfs>
Content-Type: text/plain; charset="us-ascii"
To: Olaf Kirch <okir@suse.de>
Cc: mike@waychison.com, linux-nfs <nfs@lists.sourceforge.net>, autofs mailing list <autofs@linux.kernel.org>

> Hi Mike,
>
> I'm somewhat wary of this idea, because it creates a very attractive
> target for crackers. Once an attacker managers to fool this proxy
> daemon, he can talk to your NFS Server, concealing his identity or
> even posing as root, etc.
>
> I looked at the code in the light of this, and there are a few
> soft spots.
>
>  -	you retrieve credentials in the initial negotiation
>  	only. But client credentials can change, and should be
> 	checked with every packet.
>
> 	For instance, I can connect to your service, and fork off
> 	some setuid root application, with stderr connected to that
> 	socket. Any error message the application prints will be arrive
> 	with uid 0. If I manage to make that message appear valid to you,
> 	your daemon will accept any future input unquestioned.
>

Interesting attack, although I doubt the setuid program would be attachin=
g
an SCM_CREDENTIALS to it's stderr writes.  I'll fix it up to check
credentials on all packets nevertheless.

> 	So my recommendation would be to validate credentials on
> 	every packet, and if they change from the original values
> 	received during negotiation, drop the connection.
>
> 	I'd also recommend to change the permissions on the Unix
> 	socket to 700.
>

Yup.  Sounds good to me.

>  -	This mechanism is really a special-case workaround for the
>  	mount problem, but you're creating a general purpose framework.
> 	That means if it's attacked successfully, it can be abused
> 	to attack any RPC based service on any host.
>
> 	If you make it less generic, and allow only mount calls, you'll
> 	be much safer, because in the case of a bug, an attacker will
> 	be able to send fake MOUNT packets, but nothing else.
>

Hmm.  I like the idea of keeping it generic as it may very well solve
someone else's problem as well.   As for locking it down to MOUNT (and
possibly PMAP/RPCB), how about some sort of config file that limits
PROG/VERS tuples?

>  -	In several places, you keep packet offsets (pos, bufferpos)
> 	in signed variables and compare them to unsigneds; that's
> 	dangerous.


Noted.  I'll try and audit to resolve any signedness issues.

>
>  -	Your code assumes sizeof(unsigned long) =3D=3D 4, eg here
>
> 	unsigned long len;
> 	[...]
> 		memcpy(&len, conn->buffer, 4);
> 		len =3D ntohl(len);
> 		buf =3D &conn->buffer[4];
>
> 	It's better to use uint32_t in such cases.

Yup.  Will fix.

Thanks for looking it over,

Mike Waychison



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
