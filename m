From: Ian Kent <raven@themaw.net>
Subject: Re: autofs4 + sshfs works but autofs5 + sshfs fails
Date: Tue, 12 Jun 2007 12:46:09 +0800
Message-ID: <1181623569.3604.1.camel@shark.themaw.net>
References: <50445.69.243.87.84.1181430604.squirrel@webmail.cis.jhu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <50445.69.243.87.84.1181430604.squirrel@webmail.cis.jhu.edu>
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
To: akolasny@cis.jhu.edu
Cc: autofs@linux.kernel.org

On Sat, 2007-06-09 at 19:10 -0400, akolasny@cis.jhu.edu wrote:
> Greetings:
> 
> My NIS auto.net has an entry that looks similar to:
> 
>    my_dir -fstype=fuse,reconnect,allow_other sshfs#user@some.site:/my_dir
> 
> It works fine with CentOS 4 x86, x86_64 and ia64 distributions using autofs4. I
> installed CentOS 5 x86_64 which uses autofs5 and this NIS mount failed.
> 
> Note: In order to allow NIS to properly provide the auto.net entry, I needed to
> make a minor change to the /var/yp/Makefile to allow '#' in the NIS database.
> 
> The 'automount -v -d' reports in /var/messages something like:
> 
>    Jun  8 19:02:23 c1 automount[27076]: attempting to mount entry /net/my_dir
>    Jun  8 19:02:24 c1 automount[27076]: parse_mount: parse(sun): invalid location
>    Jun  8 19:02:24 c1 automount[27076]: failed to mount /net/my_dir
> 
> 
> Does autofs-5.0.1/modules/parse_sun.c 'validate_location' function need to
> allow the '#' to get this working again? If it's something simple like this,
> would it be possible to add this to the next release?

Can you verify that this patch does the trick please.

diff --git a/modules/parse_sun.c b/modules/parse_sun.c
index 99961c3..5e14c75 100644
--- a/modules/parse_sun.c
+++ b/modules/parse_sun.c
@@ -762,12 +762,17 @@ static int validate_location(char *loc)
 	if (*ptr == ':')
 		return 1;
 
-	/* If a ':' is present now it must be a host name */
+	/*
+	 * If a ':' is present now it must be a host name, except
+	 * for those special file systems like sshfs which use "#"
+	 * and "@" in the host name part.
+	 */
 	if (check_colon(ptr)) {
 		while (*ptr && *ptr != ':') {
 			if (!(isalnum(*ptr) ||
 			    *ptr == '-' || *ptr == '.' || *ptr == '_' ||
-			    *ptr == ',' || *ptr == '(' || *ptr == ')'))
+			    *ptr == ',' || *ptr == '(' || *ptr == ')' ||
+			    *ptr == '#' || *ptr == '@'))
 				return 0;
 			ptr++;
 		}
