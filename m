From: Ondrej Valousek <webserv@s3group.com>
Subject: Re: Autofs dump map option
Date: Mon, 08 Aug 2011 09:32:35 +0200
Message-ID: <4E3F9113.6010205@s3group.cz>
References: <4E3BB3C8.9040305@s3group.cz>	
	<1312620890.3304.1.camel@perseus.themaw.net>
	<1312686584.8240.1.camel@perseus.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7504248627766193985=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1312686584.8240.1.camel@perseus.themaw.net>
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
To: Ian Kent <raven@themaw.net>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

This is a multi-part message in MIME format.
--===============7504248627766193985==
Content-Type: multipart/alternative;
 boundary="------------000407070802030609030001"

This is a multi-part message in MIME format.
--------------000407070802030609030001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Ian,

Thanks for the quick help - it works, indeed.
Funny thing:

- The original patch I have submitted some time ago which was implementing the dump map option for the first time did not dump (without your 
patch) indirect maps either.
- Your "official" patch implementing the dump map option *did* list the ldap indirect maps even without this fix, it just did not print the 
indirect nis maps. Why did it work for ldap maps?

Anyway - it works fine now. Thanks,
Ondrej


> I think this patch should help.
>
> autofs-5.0.6 - fix dumpmaps not reading maps
>
> From: Ian Kent<raven@themaw.net>
>
> The lookup modules won't read any indirect map entries (other than those
> in a file map) unless unless the browse option is set. In order to list
> the entries when tyhe dumpmap option is given the browse option needs to
> be set.
> ---
>
>   CHANGELOG    |    1 +
>   lib/master.c |    9 +++++++++
>   2 files changed, 10 insertions(+), 0 deletions(-)
>
>
> diff --git a/CHANGELOG b/CHANGELOG
> index 884a9ae..946a196 100644
> --- a/CHANGELOG
> +++ b/CHANGELOG
> @@ -3,6 +3,7 @@
>   - fix ipv6 name for lookup fix.
>   - improve mount location error reporting.
>   - fix paged query more results check.
> +- fix dumpmaps not reading maps.
>
>   28/06/2011 autofs-5.0.6
>   -----------------------
> diff --git a/lib/master.c b/lib/master.c
> index 153a38b..6c89e1d 100644
> --- a/lib/master.c
> +++ b/lib/master.c
> @@ -1283,6 +1283,15 @@ int master_show_mounts(struct master *master)
>   		printf("\nMount point: %s\n", ap->path);
>   		printf("\nsource(s):\n");
>
> +		/*
> +		 * Ensure we actually read indirect map entries so we can
> +		 * list them. The map reads won't read any indirect map
> +		 * entries (other than those in a file map) unless the
> +		 * browse option is set.
> +		 */
> +		if (ap->type == LKP_INDIRECT)
> +			ap->flags |= MOUNT_FLAG_GHOST;
> +
>   		/* Read the map content into the cache */
>   		if (lookup_nss_read_map(ap, NULL, now))
>   			lookup_prune_cache(ap, now);
>
>
>



The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited (S3 Group). Registered in Ireland no. 378073.
Registered Office: South County Business Park, Leopardstown, Dublin 18
--------------000407070802030609030001
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#ffffff" text="#000066">
    Hi Ian,<br>
    <br>
    Thanks for the quick help - it works, indeed.<br>
    Funny thing:<br>
    <br>
    - The original patch I have submitted some time ago which was
    implementing the dump map option for the first time did not dump
    (without your patch) indirect maps either.<br>
    - Your "official" patch implementing the dump map option *did* list
    the ldap indirect maps even without this fix, it just did not print
    the indirect nis maps. Why did it work for ldap maps?<br>
    <br>
    Anyway - it works fine now. Thanks,<br>
    Ondrej<br>
    <br>
    <br>
    <blockquote cite="mid:1312686584.8240.1.camel@perseus.themaw.net"
      type="cite">
      <pre wrap="">I think this patch should help.

autofs-5.0.6 - fix dumpmaps not reading maps

From: Ian Kent <a class="moz-txt-link-rfc2396E" href="mailto:raven@themaw.net">&lt;raven@themaw.net&gt;</a>

The lookup modules won't read any indirect map entries (other than those
in a file map) unless unless the browse option is set. In order to list
the entries when tyhe dumpmap option is given the browse option needs to
be set.
---

 CHANGELOG    |    1 +
 lib/master.c |    9 +++++++++
 2 files changed, 10 insertions(+), 0 deletions(-)


diff --git a/CHANGELOG b/CHANGELOG
index 884a9ae..946a196 100644
--- a/CHANGELOG
+++ b/CHANGELOG
@@ -3,6 +3,7 @@
 - fix ipv6 name for lookup fix.
 - improve mount location error reporting.
 - fix paged query more results check.
+- fix dumpmaps not reading maps.
 
 28/06/2011 autofs-5.0.6
 -----------------------
diff --git a/lib/master.c b/lib/master.c
index 153a38b..6c89e1d 100644
--- a/lib/master.c
+++ b/lib/master.c
@@ -1283,6 +1283,15 @@ int master_show_mounts(struct master *master)
 		printf("\nMount point: %s\n", ap-&gt;path);
 		printf("\nsource(s):\n");
 
+		/*
+		 * Ensure we actually read indirect map entries so we can
+		 * list them. The map reads won't read any indirect map
+		 * entries (other than those in a file map) unless the
+		 * browse option is set.
+		 */
+		if (ap-&gt;type == LKP_INDIRECT)
+			ap-&gt;flags |= MOUNT_FLAG_GHOST;
+
 		/* Read the map content into the cache */
 		if (lookup_nss_read_map(ap, NULL, now))
 			lookup_prune_cache(ap, now);



</pre>
    </blockquote>
    <br>
  <BR><HR>
The information contained in this e-mail and in any attachments is confidential and is designated solely for the attention of the intended recipient(s). If you are not an intended recipient, you must not use, disclose, copy, distribute or retain this e-mail or any part thereof. If you have received this e-mail in error, please notify the sender by return e-mail and delete all copies of this e-mail from your computer system(s).
Please direct any additional queries to: communications@s3group.com.
Thank You.
Silicon and Software Systems Limited (S3 Group). Registered in Ireland no. 378073.
Registered Office: South County Business Park, Leopardstown, Dublin 18
<BR><HR><BR></body>
</html>

--------------000407070802030609030001--


--===============7504248627766193985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============7504248627766193985==--

