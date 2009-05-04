From: Greg Wooledge <wooledg@eeg.ccf.org>
Subject: Re: how to use keys ...
Date: Mon, 4 May 2009 08:25:46 -0400
Message-ID: <20090504122546.GM1493@eeg.ccf.org>
References: <1241234851.12172.5.camel@bellerophon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1241234851.12172.5.camel@bellerophon>
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
To: raespi <raespi@estudiantes.uci.cu>
Cc: autofs@linux.kernel.org

On Fri, May 01, 2009 at 11:27:31PM -0400, raespi wrote:
> /home/teratux  :: For example
> 
> I want to be able to automount a resource from NFS in this exact
> location.

Our setup is a bit more traditional.  This is what we're doing:

$ cat /etc/auto.master
# ...
/nfs    /etc/auto.net
+auto.master

$ ypcat -k auto.master
/net/vol auto.vol       -rw,hard,intr
/net/appl auto.appl     -rw,hard,intr
/net/hosts -hosts               -rw,hard,intr
/net/home auto.home     -rw,hard,intr

$ ypcat -k auto.home
...
wooledg imadev:/home/wooledg
leek vandev:/home/leek
...

It's a bit higher maintenance than you were aiming for (we have one line
per user account in the auto.home NIS map), but it gives user account
directories directly underneath the autofs mount point (in our case it's
/net/home, but it could as easily be /home).  It also has the advantage
of flexibility -- if the physical location of a user's home directory
changes, it's just a one-line change in the auto.home map followed by
an NIS map push.

We have a mixed network of HP-UX, Debian and Red Hat machines.  This
works on all of them.
