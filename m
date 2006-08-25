From: "Joe Pruett" <joey@clean.q7.com>
Subject: Re: autofs {3, 4,
	5} and bind mounts which point to other	automount points
Date: 25 Aug 2006 09:18:00 -0700
Message-ID: <3239342301.18668365@mail.q7.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
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
To: raven@themaw.net
Cc: autofs@linux.kernel.org

The ability to have automount point to automount is something I use heavily as well.  Otherwise I end up with many hundreds of nfs mounts on the server at a time. having hundreds of bind mounts on the client is preferrable. The old sun method of doing this was:
host:/path/name:dir
which would mount host:/path/name and then symlink dir.  Now we' d use bind/loopback mounts.  But that syntax has been gone a long time.

It doesn't seem like threading should inherently cause a problem.  Each request should be a new thread and wait for the underlying mount (which might be recursive) to finish.
