From: Capelle =?iso-8859-1?q?Beno=EEt?= <capelle@labri.fr>
Subject: [PATCH] no-slashify-colons option
Date: Fri, 8 Dec 2006 14:13:03 +0100
Message-ID: <200612081413.04075.capelle@labri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

Hi,

After upgrading one of our servers from Fedora 5 (autofs-4.1.4) to Fedora 6
(autofs-5.0.1) we noticed that the "--no-slashify-colons" option was no more 
working.

We've got the following maps.
/etc/auto.master:
/nfs /etc/auto.nfs --no-slashify-colons

/etc/auto.nfs:
datas -async,ro,bg,vers=3,tcp,timeo=600,hard,intr,rsize=32768,wsize=32768,context=system_u:object_r:httpd_sys_content_t 
nfs_server:/exported_nfs

Setting log level to debug showed that the last colon from
system_u:object_r:httpd_sys_content_t (used for SELinux) was replaced by a
slash.
Dec  4 16:47:41 client automount[2094]: lookup_mount: lookup(file): 
deptinfo -> -async,ro,bg,vers=3,tcp,timeo=600,hard,intr,rsize=32768,wsize=32768,context=system_u:object_r:httpd_sys_content_t  
nfs_server:/exported_nfs
Dec  4 16:47:41 client automount[2094]: parse_mount: parse(sun): expanded 
entry: -async,ro,bg,vers=3,tcp,timeo=600,hard,intr,rsize=32768,wsize=32768,context=system_u:object_r/httpd_sys_content_t  
nfs_server:/exported_nfs

Using "--no-slashify-colons" should prevent this as it was back in version 
4.1.4.

Following patch fixes the issue. Regards.
--
Benoit

diff -ur a/lib/master_tok.l b/lib/master_tok.l
--- a/lib/master_tok.l  2006-12-06 15:10:08.000000000 +0100
+++ b/lib/master_tok.l  2006-12-06 15:17:30.000000000 +0100
@@ -91,6 +91,7 @@

 OPTIONSTR      ([\-]?([[:alpha:]_]([[:alnum:]_\-])*(=([[:alnum:]_\-])+)*)+)
 MACROSTR       (-D{OPTWS}([[:alpha:]_]([[:alnum:]_\-])*)=([[:alnum:]_\-])+)
+SLASHIFYSTR    (--(no-)?slashify-colons)
 NUMBER         [0-9]+

 DNSERVSTR1     ([[:alpha:]][[:alnum:]\-.]*(:[0-9]+)?:)
@@ -323,6 +324,11 @@

        {OPTWS} {}

+       {SLASHIFYSTR} {
+               strcpy(master_lval.strtype, master_text);
+               return(OPTION);
+       }
+
        {MACROSTR} {
                strcpy(master_lval.strtype, master_text);
                return(OPTION);
