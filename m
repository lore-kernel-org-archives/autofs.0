From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: exporting autofs managed directory using NFS
Date: Thu, 24 Jun 2004 15:19:11 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16603.10543.236802.870131@segfault.boston.redhat.com>
References: <40DADD60.5090201@intraperson.com>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <40DADD60.5090201@intraperson.com>
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
To: ramana <ramana@intraperson.com>
Cc: autofs@linux.kernel.org, hpa@zytor.com

==> Regarding [autofs] exporting autofs managed directory using NFS; ramana <ramana@intraperson.com> adds:

ramana> We are facing problems where /home is managed by autofs ( in
ramana> Autodir ) but this directory is to to be exported using NFS.

ramana> Exactly reverse of what autofs supposed to do -- lol

ramana> When tried to mount nfs exported home some where else, Persmission
ramana> denied error is reported by nfs server.

Are you saying you want to reexport an nfs mounted filesystem?  I don't
believe that is supported.

-Jeff
