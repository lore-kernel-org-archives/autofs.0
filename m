From: Ondrej Valousek <webserv@s3group.cz>
Subject: Re: NFSv4 to be a default on RHEL-6
Date: Wed, 08 Dec 2010 13:51:01 +0100
Message-ID: <4CFF7F35.9070506@s3group.cz>
References: <4CFF4CE8.6080708@s3group.cz> <1291811765.17231.6.camel@perseus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2115260925794947548=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1291811765.17231.6.camel@perseus>
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
--===============2115260925794947548==
Content-Type: multipart/alternative;
 boundary="------------030109030103080701000804"

This is a multi-part message in MIME format.
--------------030109030103080701000804
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

  On 08.12.2010 13:36, Ian Kent wrote:
> The default should be determined by mount.nfs(8) since that's what
> autofs uses to perform mounts.
I see, but it works only if the nfs4 root export is the same as /. It does not work otherwise. Example:
Server 'dorado' exporting directory /exports which is also fsid=0 for nfs4.
There is (also shared) subdirectory 'ext1' in this one. When I do:

cd /net/dorado/exports/ext1

... the export is mounted using NFSv3. Theoretically if I did:

cd /net/dorado/ext1

... I should have the same mounted via NFSv4, right? Unfortunately it does not work. But it should because:

mount dorado:/ext1 /mnt

works (giving nfs4 mount)....
Ondrej


--------------030109030103080701000804
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body text="#000066" bgcolor="#ffffff">
    On 08.12.2010 13:36, Ian Kent wrote:
    <blockquote cite="mid:1291811765.17231.6.camel@perseus" type="cite">
      <pre wrap="">The default should be determined by mount.nfs(8) since that's what
autofs uses to perform mounts.
</pre>
    </blockquote>
    I see, but it works only if the nfs4 root export is the same as /.
    It does not work otherwise. Example:<br>
    Server 'dorado' exporting directory /exports which is also fsid=0
    for nfs4.<br>
    There is (also shared) subdirectory 'ext1' in this one. When I do:<br>
    <br>
    cd /net/dorado/exports/ext1<br>
    <br>
    ... the export is mounted using NFSv3. Theoretically if I did:<br>
    <br>
    cd /net/dorado/ext1<br>
    <br>
    ... I should have the same mounted via NFSv4, right? Unfortunately
    it does not work. But it should because:<br>
    <br>
    mount dorado:/ext1 /mnt<br>
    <br>
    works (giving nfs4 mount)....<br>
    Ondrej<br>
    <br>
  </body>
</html>

--------------030109030103080701000804--


--===============2115260925794947548==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2115260925794947548==--

