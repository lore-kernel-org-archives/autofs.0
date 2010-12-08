From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: NFSv4 to be a default on RHEL-6
Date: Wed, 08 Dec 2010 15:56:24 +0100
Message-ID: <4CFF9C98.1060706@s3group.cz>
References: <4CFF4CE8.6080708@s3group.cz> <1291811765.17231.6.camel@perseus>	
	<4CFF7F35.9070506@s3group.cz> <1291815950.17231.26.camel@perseus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8320907759981996444=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1291815950.17231.26.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: Ian Kent <ikent@redhat.com>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--===============8320907759981996444==
Content-Type: multipart/alternative;
 boundary="------------000709060503060402010207"

This is a multi-part message in MIME format.
--------------000709060503060402010207
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  On 08.12.2010 14:45, Ian Kent wrote:
> On Wed, 2010-12-08 at 13:51 +0100, Ondrej Valousek wrote:
>> On 08.12.2010 13:36, Ian Kent wrote:
>>> The default should be determined by mount.nfs(8) since that's what
>>> autofs uses to perform mounts.
>> I see, but it works only if the nfs4 root export is the same as /. It
>> does not work otherwise. Example:
>> Server 'dorado' exporting directory /exports which is also fsid=0 for
>> nfs4.
>> There is (also shared) subdirectory 'ext1' in this one. When I do:
>>
>> cd /net/dorado/exports/ext1
>>
>> ... the export is mounted using NFSv3. Theoretically if I did:
>>
>> cd /net/dorado/ext1
>>
>> ... I should have the same mounted via NFSv4, right? Unfortunately it
>> does not work. But it should because:
>>
>> mount dorado:/ext1 /mnt
>>
>> works (giving nfs4 mount)....
> The only information the hosts map has to go on is the export list
> received from the server.
>
> There is no way for autofs to know that /exports is the global root from
> the mountd exports information. It only knows that /exports is an export
> and neither does it know what NFS version the server may offer for this
> mount. That information just isn't available.
>
> As I said, I thought in recent Fedora releases (not sure now when this
> should have happened), that
>
> mount<server>:/exports /<some mount point>
>
> and
>
> mount<server>:/ /<some mount point>
>
> should both work and mount as NFSv4. Correct me if I'm wrong but your
> point is that it is mounting as NFSv3 so perhaps we should log a bug and
> see what the experts have to say on this.
>
> Ian
>
>
Hi Ian,

I understand that autofs can not know that /exports is a global root. I just thought that mine:

cd /net/dorado/ext1

... (i.e. omitting the "exports" word) should work as this way should autofs pass something like this : "mount.nfs dorado:/ext1 
/net/dorado/ext1" which would succeed then, resulting in a nfs4 mount. What happens now is (obviously) that autofs can not find 'ext1' in 
the exports information from 'dorado' and so it fails even without trying....

Ondrej

--------------000709060503060402010207
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000066" bgcolor="#ffffff">
    On 08.12.2010 14:45, Ian Kent wrote:
    <blockquote cite="mid:1291815950.17231.26.camel@perseus" type="cite">
      <pre wrap="">On Wed, 2010-12-08 at 13:51 +0100, Ondrej Valousek wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On 08.12.2010 13:36, Ian Kent wrote: 
</pre>
        <blockquote type="cite">
          <pre wrap="">The default should be determined by mount.nfs(8) since that's what
autofs uses to perform mounts.
</pre>
        </blockquote>
        <pre wrap="">I see, but it works only if the nfs4 root export is the same as /. It
does not work otherwise. Example:
Server 'dorado' exporting directory /exports which is also fsid=0 for
nfs4.
There is (also shared) subdirectory 'ext1' in this one. When I do:

cd /net/dorado/exports/ext1

... the export is mounted using NFSv3. Theoretically if I did:

cd /net/dorado/ext1

... I should have the same mounted via NFSv4, right? Unfortunately it
does not work. But it should because:

mount dorado:/ext1 /mnt

works (giving nfs4 mount)....
</pre>
      </blockquote>
      <pre wrap="">
The only information the hosts map has to go on is the export list
received from the server.

There is no way for autofs to know that /exports is the global root from
the mountd exports information. It only knows that /exports is an export
and neither does it know what NFS version the server may offer for this
mount. That information just isn't available.

As I said, I thought in recent Fedora releases (not sure now when this
should have happened), that

mount &lt;server&gt;:/exports /&lt;some mount point&gt;

and 

mount &lt;server&gt;:/ /&lt;some mount point&gt;

should both work and mount as NFSv4. Correct me if I'm wrong but your
point is that it is mounting as NFSv3 so perhaps we should log a bug and
see what the experts have to say on this.

Ian


</pre>
    </blockquote>
    Hi Ian,<br>
    <br>
    I understand that autofs can not know that /exports is a global
    root. I just thought that mine:<br>
    <br>
    cd /net/dorado/ext1<br>
    <br>
    ... (i.e. omitting the "exports" word) should work as this way
    should autofs pass something like this : "mount.nfs dorado:/ext1
    /net/dorado/ext1" which would succeed then, resulting in a nfs4
    mount. What happens now is (obviously) that autofs can not find
    'ext1' in the exports information from 'dorado' and so it fails even
    without trying....<br>
    <br>
    Ondrej<br>
  </body>
</html>

--------------000709060503060402010207--


--===============8320907759981996444==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============8320907759981996444==--

