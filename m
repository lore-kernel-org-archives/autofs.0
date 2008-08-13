From: Carsten Aulbert <carsten.aulbert@aei.mpg.de>
Subject: Re: Automounter losing track of mounts...
Date: Wed, 13 Aug 2008 21:04:18 +0200
Message-ID: <48A33032.1060506@aei.mpg.de>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030401020600000505050602"
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A58BD@hqemmail01.nvidia.com>
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

This is a multi-part message in MIME format.
--------------030401020600000505050602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



Stephen Biggs wrote:

> 
> This seems to indicate failure to lock /etc/mtab (??) and then failing
> to retry correctly, but setting its mount table as if it succeeded.

We had a related issue quite a bit and /etc/mtab and /proc/mounts went
out of sync. Right now we are symlinking /etc/mtab to /proc/mounts. It
works, but I don't know if that's the best solution for it.

HTH

Carsten

--------------030401020600000505050602
Content-Type: text/x-vcard; charset=utf-8;
 name="carsten_aulbert.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="carsten_aulbert.vcf"

begin:vcard
fn:Carsten Aulbert
n:Aulbert;Carsten
org:Max Planck Institute for Gravitational Physics;Observational Relativity and Cosmology
adr:;;Callinstrasse 38;Hannover;;30167;Germany
email;internet:carsten.aulbert@aei.mpg.de
title:Dr
tel;work:+49 511 762 17185
tel;fax:+49 511 762 17193
tel;home:+49 511 220 4537
tel;cell:+49 1577 398 7963
x-mozilla-html:FALSE
url:http://www.aei.mpg.de/
version:2.1
end:vcard


--------------030401020600000505050602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--------------030401020600000505050602--

