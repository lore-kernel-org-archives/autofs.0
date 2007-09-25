From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: automount on redhat
Date: Tue, 25 Sep 2007 10:07:00 -0400
Message-ID: <x49abra7saj.fsf@segfault.boston.devel.redhat.com>
References: <39f1062c0709210712q2c9a8c69oa2c21c3bded9a0d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <39f1062c0709210712q2c9a8c69oa2c21c3bded9a0d0@mail.gmail.com>
	(Jayanthi V.'s message of "Fri\, 21 Sep 2007 22\:12\:40 +0800")
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
To: Jayanthi V <vjnthi@gmail.com>
Cc: autofs@linux.kernel.org

"Jayanthi V" <vjnthi@gmail.com> writes:

> Hi all,
>
> how to automount on RedHat
> ... When I start the autofs service I get these errors. ... How do I
> get it so it
> automounts my directories from my NIS domain? ... failed to load map,
> exiting ...
>
> Start /usr/sbin/automount --timeout=60 /epd yp auto_epd -rw,soft
> failed to load map, exiting
> Start /usr/sbin/automount --timeout=60 /erd/doc yp auto_doc -rw,soft
> failed to load map, exiting

What does the 'ypwhich' command show?
What is the output of 'ypcat -k auto_epd'?
What is the output of 'rpm -q autofs'?

-Jeff
