From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: No include of NIS maps in automounter maps possible
	any more?
Date: Thu, 30 Nov 2006 09:42:41 -0500
Message-ID: <x49odqpuhb2.fsf@segfault.boston.devel.redhat.com>
References: <456EE067.3090208@embl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <456EE067.3090208@embl.de> (Frank Thommen's message of "Thu,
	30 Nov 2006 14:45:11 +0100")
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
To: Frank Thommen <fthommen@embl.de>
Cc: autofs@linux.kernel.org

==> On Thu, 30 Nov 2006 14:45:11 +0100, Frank Thommen <fthommen@embl.de> said:

Frank> Hi,
Frank> I hope this question is not too basic for this list, but I could not 
Frank> find any answer in the list archives or through friend google.

Frank> With automount version 4.1.3-187 (running on CentOS 4.4) I
Frank> could have an automounter map (not auto.master) to be like:

Frank> key1   host1:/path1
Frank> key2   host2:/path2
Frank> +map.in.nis

Frank> This way I could add specific local mounts to a generally available NIS 
Frank> map or override NIS given keys with my own ones.

Frank> With automount 4.1.4-33 (on Fedora Core 5) this doesn't work any more. 
Frank> The additional map is simply ignored.  I tried with '+map.in.nis' and 
Frank> '+yp:map.in.nis' to no avail.

Frank> 'automount' in nsswitch.conf is on 'files nis' in both cases.


Frank> Is this a bug or a wanted feature in 4.1.4? We have
Frank> configured a lot of hosts with above setup and whith the
Frank> current OS-updates this starts to break.

I just posted some patches that implement this for 4.1.4.  Ian's
pretty busy with v5, so I'm not sure when they'll be included.  For
now, it's safe to rebuild your centos RPM on FC-5.

Frank> Is there an other way to *combine* nis and local maps for
Frank> automounting? Any hints or pointers are appreciated.

Well, you could use the multi-map syntax.  In auto.master, you would
have something like the following:

/foo  multi: file /etc/auto.foo -- yp map.in.nis

-Jeff
