From: Steve Thompson <smt@vgersoft.com>
Subject: using autofs variable in options
Date: Wed, 10 Mar 2004 15:20:33 -0500 (EST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0403101516230.9109@vger.vgersoft.com>
Reply-To: smt@vgersoft.com
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: autofs@linux.kernel.org

Using autofs 3.1.7.-various under Linux (also various). The autofs(5) man
pages states that "the following special variables will be substituted in
the key and location fields of an automounter map" and that additional
variables can be defined with the -D option. Substitutions in the options
field appears not to have any effect. Can this me made to work? For
example:

	key1	-rw,$OPTA	location1
	key2	-rw,$OPTB	location2

and so on. Note that the variables may differ from key to key, but all
are available in the environment of the automounter.

TIA,
-steve
