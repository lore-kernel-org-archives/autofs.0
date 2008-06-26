From: Jim Carter <jimc@math.ucla.edu>
Subject: Re: Direct mount newbie question
Date: Wed, 25 Jun 2008 17:07:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0806251647250.15233@xena.cft.ca.us>
References: <A2ECBF49F352C24F9DF65BB529DCBC70187A578E@hqemmail01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <A2ECBF49F352C24F9DF65BB529DCBC70187A578E@hqemmail01.nvidia.com>
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
To: Stephen Biggs <sbiggs@nvidia.com>
Cc: autofs@linux.kernel.org

On Wed, 25 Jun 2008, Stephen Biggs wrote:

> I have /home as an indirect mount point using a yp:auto.home key file.
> 
> I have an application that I have no control over nor ability to change
> its behavior. It does many many searches for a file that I will call
> .junk, starting at the cwd and going up the tree until it either finds /
> or the file.  If the user is anywhere under the /home directory, this
> search eventually tries to open /home/.junk and fails, but not until it
> triggers the automounter to try to mount a non-existent directory named
> .junk.  Because of the many searches, it seriously slows down execution
> due to the automounting storm and consequent NFS dialogs over the
> network.

Is the application by any chance called "Apache" and the file is .htaccess? 
We see the same phenomenon on our webservers.  However, in our case we 
would be looking for /net/.htaccess (interpreting .htaccess as a hostname), 
and our DNS efficiently determines that there is no host 
.htaccess.math.ucla.edu.  So we've never felt the need to work around it.

If the /home map were involved, I think we would do a YP lookup in 
yp:auto.home for the named user, find that he has no homedir listed, and 
return ENOENT on the file.  In any case, I'm puzzled about the automounting 
storm and NFS chatter; unless your maps are quite different from ours, 
without an entry in whatever map for the nonexistent "user", there's 
nothing to mount.

> The best way I could see to do it was as such:
> --snip--
> In /etc/auto.data, I have one line:
> /home/.junk -mode=555,fstype=tmpfs,ro :/.junk

Tempting fate here.  I'll be interested to read other people's comments 
about how to make this work.  If feasible, sneaking content (like a 
zero-length .htaccess file) into /home or /net would be a more elegant 
way to shut up Apache than to try and fail to automount it in the normal 
way.

James F. Carter          Voice 310 825 2897    FAX 310 206 6673
UCLA-Mathnet;  6115 MSA; 405 Hilgard Ave.; Los Angeles, CA, USA 90095-1555
Email: jimc@math.ucla.edu  http://www.math.ucla.edu/~jimc (q.v. for PGP key)
