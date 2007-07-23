From: Ian Kent <raven@themaw.net>
Subject: Re: AutoFS and LDAP
Date: Mon, 23 Jul 2007 23:07:32 +0800
Message-ID: <1185203252.3263.6.camel@raven.themaw.net>
References: <46A10097.1020403@cs.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <46A10097.1020403@cs.ou.edu>
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
To: jsummers@bachman.cs.ou.edu
Cc: autofs@linux.kernel.org

On Fri, 2007-07-20 at 13:36 -0500, Jim Summers wrote:
> Hello All,
> 
> I have been attempting to get autofs5 to work with my ldap config.  The way I 
> am set up is:
> 
> FC6 / FC7 clients and redhat servers.
> auto.home info for each user is stored in ldap
> auto.master is stored locally on each client
> 
> The mounts do not happen.  Here is what I see when starting autofs:
> ======
> Jul 20 13:22:53 lch automount[3427]: Starting automounter version 5.0.1-11, 
> master map auto.master
> Jul 20 13:22:53 lch automount[3427]: using kernel protocol version 5.00
> Jul 20 13:22:53 lch automount[3427]: master_error: syntax error while parsing map.
> Jul 20 13:22:53 lch automount[3427]: mounted indirect mount on /misc with 
> timeout 300, freq 75 seconds
> Jul 20 13:22:53 lch automount[3427]: mounted indirect mount on /net with 
> timeout 300, freq 75 seconds

Does this patch fix the problem?
Ian

---
diff --git a/lib/master_tok.l b/lib/master_tok.l
index 9bfeefa..ff69a24 100644
--- a/lib/master_tok.l
+++ b/lib/master_tok.l
@@ -272,7 +272,7 @@ OPTTOUT		(-t{OPTWS}|-t{OPTWS}={OPTWS}|--timeout{OPTWS}|--timeout{OPTWS}={OPTWS})
 		return DNSERVER;
 	}
 
-	{DNATTRSTR} {
+	{DNATTRSTR}/"=" {
 		strcpy(master_lval.strtype, master_text);
 		return DNATTR;
 	}
