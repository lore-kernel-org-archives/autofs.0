From: mike@waychison.com
Subject: Re: [PATCH/RFC 1/2] rpcproxyd
Date: Mon, 14 Mar 2005 15:08:38 -0500 (EST)
Message-ID: <48774.66.11.176.22.1110830918.squirrel@webmail1.hrnoc.net>
References: <37086.66.11.176.22.1110228763.squirrel@webmail1.hrnoc.net>
    <37093.66.11.176.22.1110228819.squirrel@webmail1.hrnoc.net>
    <20050314105249.GH14815@suse.de>
    <48275.66.11.176.22.1110821698.squirrel@webmail1.hrnoc.net>
    <20050314192440.GC29939@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20050314192440.GC29939@suse.de>
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
> On Mon, Mar 14, 2005 at 12:34:58PM -0500, mike@waychison.com wrote:
>> > 	For instance, I can connect to your service, and fork off
>> > 	some setuid root application, with stderr connected to that
>> > 	socket. Any error message the application prints will be arrive
>> > 	with uid 0. If I manage to make that message appear valid to you,
>> > 	your daemon will accept any future input unquestioned.
>> >
>>
>> Interesting attack, although I doubt the setuid program would be
>> attaching
>> an SCM_CREDENTIALS to it's stderr writes.  I'll fix it up to check
>> credentials on all packets nevertheless.
>
> The application doesn't have to pass them explicitly. They'll be
> attached automatically by the kernel.

Ah. Didn't know that.  This makes verifying each request much more critic=
al.

Mike Waychison



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
NFS maillist  -  NFS@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/nfs
