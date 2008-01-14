From: "Coe, Colin C. (Unix Engineer)" <Colin.Coe@woodside.com.au>
Subject: Query automount maps
Date: Tue, 15 Jan 2008 07:55:22 +0900
Message-ID: <BAC1D28A5AB852439A6914CA7AB4E63F051929F0@permls05.wde.woodside.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-class: urn:content-classes:message
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


Hi Ian and all

Is there a way I can ask the automount process running on a client what
maps it has?  I'd like to be able to say "tell me all the maps you know
about" or "tell me the server:/path/to/somewhere for
/nfs/server/some/path".  Does this make sense?

Poking around it looked like autofs-ldap-auto-master would do the trick
but strace'ing showed that it actually talks to the autofs/LDAP
server(s) not the local automount process.  Also,
autofs-ldap-auto-master seems to have gone away with EL5.

I'm really just after a way of checking that autofs map changes are
picked up by the clients.

Thanks

CC

NOTICE: This email and any attachments are confidential. 
They may contain legally privileged information or 
copyright material. You must not read, copy, use or 
disclose them without authorisation. If you are not an 
intended recipient, please contact us at once by return 
email and then delete both messages and all attachments.
