From: Brian Long <brilong@cisco.com>
Subject: Re: questions on auto.master file format
Date: Thu, 04 Mar 2004 10:46:01 -0500
Sender: autofs-bounces@linux.kernel.org
Message-ID: <1078415161.2236.10.camel@brilong-lnx2.cisco.com>
References: <16452.51314.769206.991484@segfault.boston.redhat.com>
	 <Pine.LNX.4.58.0403031455220.16583@wombat.indigo.net.au>
	 <16453.61187.553910.939557@segfault.boston.redhat.com>
	 <Pine.LNX.4.58.0403041224300.7374@wombat.indigo.net.au>
	 <1078409214.29340.33.camel@brilong-lnx2.cisco.com>
	 <Pine.LNX.4.58.0403042231270.4704@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0403042231270.4704@raven.themaw.net>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

Sorry, same request I asked about in a previous thread.  The ability to
have an /etc/auto.direct map like this:

/netapp/tonka           /               tonka:/vol/root \
                        /vol/vol1       tonka:/vol/vol1 \
                        /vol/vol2       tonka:/vol/vol2 \
                        /vol/vol3       tonka:/vol/vol3

The auto_master on Solaris has this:
+auto_master
/-      /etc/auto.direct

/Brian/
